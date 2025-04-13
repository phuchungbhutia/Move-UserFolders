# Move-UserFolders.ps1

A PowerShell script to automatically move default user folders (like Desktop, Documents, Downloads, etc.) from `C:\Users\<username>` to `D:\Users\<username>` in Windows 11. The script also updates the Windows Registry so the system uses the new locations as defaults.

## ⚙️ Features

- Automatically detects the currently logged-in user
- Moves contents of:
  - Desktop
  - Documents
  - Downloads
  - Music
  - Pictures
  - Videos
- Updates registry paths accordingly
- Restarts File Explorer to apply changes

## 🧪 Tested On

- Windows 11 (22H2 and 23H2)
- PowerShell 5.1+

## 📦 Installation

Clone the repo or download the script file:

```bash
git clone https://github.com/phuchungbhutia/Move-UserFolders.git
