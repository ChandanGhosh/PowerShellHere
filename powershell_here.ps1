# powershell here.
# powershell path
$command = "$PSHOME\powershell.exe -NoExit -NoProfile -Command ""Set-Location '%V'"""

# for right clicking on the background in drives, folders
$menu1 = 'Open PowerShell Here'

'directory', 'directory\background', 'drive' | ForEach-Object {
    New-Item -Path "Registry::HKEY_CLASSES_ROOT\$_\shell" -Name runas\command -Force |
    Set-ItemProperty -Name '(default)' -Value $command -PassThru |
    Set-ItemProperty -Path {$_.PSParentPath} -Name '(default)' -Value $menu1 -PassThru 
    #|Set-ItemProperty -Name HasLUAShield -Value ''
}

# for right clicking on the background as an administrator in drives, folders
$menu2 = 'Open PowerShell(As Administrator) Here'
$command = "$PSHOME\powershell.exe -NoExit -NoProfile -Command ""Set-Location '%V'"""
 
'directory', 'directory\background', 'drive' | ForEach-Object {
    New-Item -Path "Registry::HKEY_CLASSES_ROOT\$_\shell" -Name runas\command -Force |
    Set-ItemProperty -Name '(default)' -Value $command -PassThru |
    Set-ItemProperty -Path {$_.PSParentPath} -Name '(default)' -Value $menu2 -PassThru |
    Set-ItemProperty -Name HasLUAShield -Value ''
}