#!/usr/bin/env bash

set -e

REPO_RAW_BASE="https://raw.githubusercontent.com/KenleyundLeon/ProxmoxVE-Fake-Subscription/main"

PVE_API_DIR="/usr/share/perl5/PVE/API2"
JS_DIR="/usr/share/javascript/proxmox-widget-toolkit"

FILES_API=(
  "Cluster.pm"
  "Subscription.pm"
)

FILE_JS="proxmoxlib.js"

restart_services() {
  systemctl restart pveproxy.service pvedaemon.service
  echo
  echo "✅ Fertig!"
  echo "Die Subscription kann nun mit dem subscription key: 'pve8p-1234567890' aktiviert werden."
}

backup_files() {
  echo "🔹 Erstelle Backups (.bak)..."
  for file in "${FILES_API[@]}"; do
    if [[ -f "$PVE_API_DIR/$file" ]]; then
      cp "$PVE_API_DIR/$file" "$PVE_API_DIR/$file.bak"
      echo "  ✔ Backup erstellt: $file.bak"
    fi
  done

  if [[ -f "$JS_DIR/$FILE_JS" ]]; then
    cp "$JS_DIR/$FILE_JS" "$JS_DIR/$FILE_JS.bak"
    echo "  ✔ Backup erstellt: $FILE_JS.bak"
  fi
}

install_files() {
  backup_files
  echo
  echo "🔹 Ersetze Dateien mit Versionen aus dem GitHub-Repo..."

  for file in "${FILES_API[@]}"; do
    curl -fsSL "$REPO_RAW_BASE/$file" -o "$PVE_API_DIR/$file"
    echo "  ✔ Installiert: $file"
  done

  curl -fsSL "$REPO_RAW_BASE/$FILE_JS" -o "$JS_DIR/$FILE_JS"
  echo "  ✔ Installiert: $FILE_JS"

  restart_services
}

restore_backup() {
  echo "🔹 Stelle Backups wieder her..."
  for file in "${FILES_API[@]}"; do
    if [[ -f "$PVE_API_DIR/$file.bak" ]]; then
      mv "$PVE_API_DIR/$file.bak" "$PVE_API_DIR/$file"
      echo "  ✔ Wiederhergestellt: $file"
    else
      echo "  ⚠ Kein Backup gefunden für: $file"
    fi
  done

  if [[ -f "$JS_DIR/$FILE_JS.bak" ]]; then
    mv "$JS_DIR/$FILE_JS.bak" "$JS_DIR/$FILE_JS"
    echo "  ✔ Wiederhergestellt: $FILE_JS"
  else
    echo "  ⚠ Kein Backup gefunden für: $FILE_JS"
  fi

  restart_services
}

if [[ $EUID -ne 0 ]]; then
  echo "❌ Bitte als root ausführen."
  exit 1
fi

echo "========================================"
echo " Proxmox VE Fake Subscription Script"
echo "========================================"
echo
echo "🔹 Starte automatische Installation..."
install_files
