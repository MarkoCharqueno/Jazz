Set-ExecutionPolicy Unrestricted

Set-Location -Path "$PSScriptRoot"

#Set Timezone
Set-TimeZone -Id "Central Standard Time"

#Copy ChangeName script to local PC
New-Item -Path 'C:\Temp' -ItemType Directory -Force
Copy-Item -Path '.\ChangeName.ps1' -Destination 'C:\Temp' -Force

#Make scheduled task to start ChangeName script at first logon
$trigger = New-ScheduledTaskTrigger -AtLogOn

$action = New-ScheduledTaskAction -Execute 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -Argument 'C:\Temp\ChangeName.ps1'

$principal = New-ScheduledTaskPrincipal -UserId 'NT AUTHORITY\SYSTEM' -LogonType Interactive

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Change Computer Name" -Principal $principal -Description "This scheduled task will prompt for the computer name to be changed at first logon"