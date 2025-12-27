Gerne 👍
Ich habe den Hinweis **explizit ergänzt**, dass **die Aktivierung über den Key erfolgt**.
Hier ist die **aktualisierte `README.md` (finale Version)**:

---

# Proxmox VE Fake Subscription

Dieses Repository stellt ein Bash-Script bereit, mit dem die **Subscription-Prüfung in Proxmox VE kosmetisch angepasst** werden kann.  
Dadurch kann eine **Subscription über einen Test-Key aktiviert werden**, ohne dass Fehlermeldungen im Webinterface erscheinen.

⚠️ **Wichtig:**  
Die Subscription ist **rein kosmetisch**.  
Sie **fügt keine Funktionen hinzu**, **entfernt keine Funktionen** und **schränkt nichts ein**.

---

## ✨ Features

- Kosmetische Anpassung der Subscription-Prüfung
- Aktivierung der Subscription über einen Test-Key möglich
- Kein Einfluss auf Funktionalität oder Stabilität
- Automatisches Backup der Originaldateien (`.bak`)
- Einfache Wiederherstellung der Backups
- Neustart der benötigten Proxmox-Dienste inklusive
- Direkt ausführbar via `curl | bash`

---

## 📁 Betroffene Dateien

### Ersetzt werden folgende Dateien:

**Perl API (PVE):**
- `/usr/share/perl5/PVE/API2/Cluster.pm`
- `/usr/share/perl5/PVE/API2/Subscription.pm`

**JavaScript (Web UI):**
- `/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js`

Vor jeder Änderung werden automatisch **Backups mit `.bak` Endung** erstellt.

---

## 🚀 Installation (empfohlen)

Das Script kann direkt von GitHub gestartet werden:

```
curl -fsSL https://raw.githubusercontent.com/KenleyundLeon/ProxmoxVE-Fake-Subscription/main/install.sh | sudo bash
````

⚠️ Das Script **muss als root** ausgeführt werden.
Falls du nicht als root angemeldet bist, verwende:

```
sudo bash
```

---

## 🖥️ Script-Menü

Nach dem Start erscheint ein einfaches Terminal-Menü:

```
1) Installieren (Backup + Ersetzen)
2) Backup wiederherstellen
```

### Option 1 – Installieren

* Erstellt Backups der Originaldateien (`.bak`)
* Ersetzt die Dateien durch die Versionen aus diesem Repository
* Startet die benötigten Proxmox-Dienste neu
* Ermöglicht die Aktivierung der Subscription über einen Test-Key

### Option 2 – Backup wiederherstellen

* Stellt alle zuvor gesicherten Originaldateien wieder her
* Startet die Proxmox-Dienste neu

---

## 🔁 Neustart der Dienste

Nach Installation oder Wiederherstellung werden automatisch folgende Dienste neu gestartet:

```
systemctl restart pveproxy.service pvedaemon.service
```

---

## 🔑 Subscription aktivieren

Nach erfolgreicher Installation kann die Subscription im **Proxmox Webinterface** aktiviert werden, indem folgender **Test-Subscription-Key** eingetragen wird:

```
pve8p-1234567890
```

Die Subscription wird dadurch als **aktiv angezeigt**, ohne dass Funktionen freigeschaltet oder eingeschränkt werden.

---

## ⚠️ Haftungsausschluss

* Dieses Projekt dient **ausschließlich zu Test- und Lernzwecken**
* Keine Garantie oder Haftung für Schäden
* Nutzung auf eigene Verantwortung
* Kein offizielles Proxmox-Projekt

---

## ❤️ Credits

Erstellt von **Kenley**
Pull Requests und Verbesserungen sind willkommen!
