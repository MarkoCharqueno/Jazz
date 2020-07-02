#Copy ChangeName script to local PC
Copy-Item -Path '.\Imaging\ChangeName.ps1' -Destination 'C:\Temp\' -Force

#Make scheduled task to start ChangeName script at first logon
$trigger = New-ScheduledTaskTrigger -AtLogOn

$action = New-ScheduledTaskAction -Execute 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -Argument 'C:\Temp\ChangeName.ps1'

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Change Computer Name" -Description "This scheduled task will prompt for the computer name to be changed at first logon"