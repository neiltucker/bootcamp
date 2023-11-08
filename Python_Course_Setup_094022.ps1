### Manual setup of 094022 Python Class (Run in Administrator:PowerShell ISE console)
### Prerequisites:
# 1. Install Python 3.X or higher  (https://www.python.org/downloads/windows/)
# 2. Install a PDF and Excel viewer (https://www.libreoffice.org/download/download-libreoffice/)
# 3. Install Pycharm Community Edition (https://www.jetbrains.com/pycharm/download/#section=windows)
# 4. Enable PowerShell Script execution (e.g. Set-ExecutionPolicy Unrestricted)
# 5. Copy the course setup file (094022Files1_0.zip) to the Desktop of the computer.

# Copy Files to Work Folder
$WorkFolder = 'C:\094022Data\' 
$Desktop = [Environment]::GetFolderPath("Desktop")
$SetupFile = $Desktop + "\094022Files1_0.zip"
Get-ChildItem -Path $SetupFile -Recurse |  Unblock-File 
New-Item -Path C:\Temp -Type Directory -Force -ErrorAction "SilentlyContinue"
Expand-Archive -LiteralPath $SetupFile -DestinationPath C:\Temp -Force -ErrorAction "SilentlyContinue"
Copy-Item C:\Temp\094022Data\ -Destination $WorkFolder -Recurse 

#   Configure File Explorer Settings
$VarWindowsExplorer = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $VarWindowsExplorer AlwaysShowMenus 1 -Force
Set-ItemProperty $VarWindowsExplorer FolderContentsInfoTip 1 -Force
Set-ItemProperty $VarWindowsExplorer Hidden 1 -Force
Set-ItemProperty $VarWindowsExplorer HideDrivesWithNoMedia 0 -Force
Set-ItemProperty $VarWindowsExplorer HideFileExt 0 -Force
Set-ItemProperty $VarWindowsExplorer IconsOnly 0 -Force
Set-ItemProperty $VarWindowsExplorer ShowSuperHidden 0 -Force
Set-ItemProperty $VarWindowsExplorer ShowStatusBar 1 -Force
Stop-Process -ProcessName: Explorer -Force

# Configure applications and Environment Variables
$PrintToPDF = Get-WindowsOptionalFeature -Online -FeatureName Printing-PrintToPDFServices-Features
if($PrintToPDF.State -ne "Enabled"){Enable-WindowsOptionalFeature -Online -Featurename Printing-PrintToPDFServices-Features -All}
$PythonPath = $env:userprofile + "\AppData\Local\Programs\Python\Python39"
$PythonScriptPath = $env:userprofile + "\AppData\Local\Programs\Python\Python39\Scripts"
$env:Path = $env:Path + ";" + $PythonScriptPath
$env:Path = $env:Path + ";" + $PythonPath

# Finish Setup
Start-Sleep 30
Write-Output "Setup Complete."
Write-Output "Verify setup by running the 'pip' and 'python' commands from an Administrator Command Prompt."
Write-Output "Open PyCharm and create a new project.  Close PyCharm without making any changes."

