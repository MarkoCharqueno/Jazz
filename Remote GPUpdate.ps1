$Cmd = '
@echo off
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Group Policy\History" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Group Policy\History" /f
RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
RD /S /Q "%WinDir%\System32\GroupPolicy"
secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
gpupdate /force
'

$Computer = "Computer Name Here"

New-Item -Path \\$Computer\C$\Temp\InstallPrinter.bat -Force
Add-Content \\$Computer\C$\Temp\InstallPrinter.bat $Cmd
psexec \\$Computer C:\Temp\InstallPrinter.bat
Start-Sleep -Seconds 5
Remove-Item -Path \\$Computer\C$\Temp -Force -Recurse