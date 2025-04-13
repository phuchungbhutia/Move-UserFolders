# Get current username and paths
$userName = $env:USERNAME
$oldRoot = "C:\Users\$userName"
$newRoot = "D:\Users\$userName"

# List of user folders to move
$userFolders = @(
    "Desktop",
    "Documents",
    "Downloads",
    "Music",
    "Pictures",
    "Videos"
)

# Create new root directory if it doesn't exist
if (!(Test-Path -Path $newRoot)) {
    New-Item -Path $newRoot -ItemType Directory -Force
}

foreach ($folder in $userFolders) {
    $oldPath = Join-Path $oldRoot $folder
    $newPath = Join-Path $newRoot $folder

    # Create new folder if it doesn't exist
    if (!(Test-Path -Path $newPath)) {
        New-Item -Path $newPath -ItemType Directory -Force
    }

    # Move contents if the old folder exists and is not empty
    if (Test-Path -Path $oldPath) {
        Write-Output "Moving $folder from $oldPath to $newPath..."
        Move-Item -Path "$oldPath\*" -Destination $newPath -Force -ErrorAction SilentlyContinue
    }

    # Update the shell folder location in the registry
    $shellFoldersPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
    Set-ItemProperty -Path $shellFoldersPath -Name $folder -Value $newPath

    # For backward compatibility (optional)
    $knownFoldersPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
    Set-ItemProperty -Path $knownFoldersPath -Name $folder -Value $newPath

    Write-Output "$folder location updated to $newPath"
}

# Restart Explorer to apply changes
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Output "✅ User folders moved and registry updated for user '$userName'."

# Powershell 
#Set-ExecutionPolicy RemoteSigned -Scope Process
#.\Move-UserFolders.ps1

