# powershell here.
# powershell path
$psprompt = "function prompt {$p = Split-Path -leaf -path (Get-Location); "[$p] "}"
$pspath= "$PSHOME\powershell.exe -NoExit $psprompt"

# for right clicking on folders
New-Item HKLM:\SOFTWARE\Classes\Directory\shell\PSOpenHere -force 
Set-Item HKLM:\SOFTWARE\Classes\Directory\shell\PSOpenHere "Open PowerShell Here"
New-item HKLM:\SOFTWARE\Classes\Directory\shell\PSOpenHere\command -force
Set-item HKLM:\SOFTWARE\Classes\Directory\shell\PSOpenHere\command "$pspath Set-Location '%L'"

# for right clicking on drives
New-Item HKLM:\SOFTWARE\Classes\Drive\shell\PSOpenHere -force 
Set-Item HKLM:\SOFTWARE\Classes\Drive\shell\PSOpenHere "Open PowerShell Here"
New-item HKLM:\SOFTWARE\Classes\Drive\shell\PSOpenHere\command -force
Set-item HKLM:\SOFTWARE\Classes\Drive\shell\PSOpenHere\command "$pspath Set-Location '%L'"

# for right clicking on the background of folders
New-Item HKLM:\SOFTWARE\Classes\Directory\Background\shell\PSOpenHere -force 
Set-Item HKLM:\SOFTWARE\Classes\Directory\Background\shell\PSOpenHere "Open PowerShell Here"
New-item HKLM:\SOFTWARE\Classes\Directory\Background\shell\PSOpenHere\command -force
Set-item HKLM:\SOFTWARE\Classes\Directory\Background\shell\PSOpenHere\command "$pspath"

# for right clicking on the background as an administrator in drives, folders
$menu = 'Open PowerShell(As Administrator) Here'
$command = "$PSHOME\powershell.exe -NoExit -NoProfile -Command ""Set-Location '%V'; $psprompt"""
 
'directory', 'directory\background', 'drive' | ForEach-Object {
    New-Item -Path "Registry::HKEY_CLASSES_ROOT\$_\shell" -Name runas\command -Force |
    Set-ItemProperty -Name '(default)' -Value $command -PassThru |
    Set-ItemProperty -Path {$_.PSParentPath} -Name '(default)' -Value $menu -PassThru |
    Set-ItemProperty -Name HasLUAShield -Value ''
}
