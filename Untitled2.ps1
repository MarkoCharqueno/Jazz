$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument 'C:\ClearOutlookCacheLocation'

$trigger = New-ScheduledTaskTrigger -