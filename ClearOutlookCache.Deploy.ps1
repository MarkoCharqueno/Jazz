#Copy the clear Outlook cache script to client
Copy-Item -Path '\\CN00009010\C$\Automation and Innovation\Scheduled Tasks\ClearOutlookCache.ps1' -Destination 'C:\Automation and Innovation\Scheduled Tasks\' -Force

#Create a scheduled task to run Outlook cache script upon PC bootup
$action = New-ScheduledTaskAction -Execute 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -Argument 'C:\Automation and Innovation\Scheduled Tasks\ClearOutlookCache.ps1'

$trigger = New-ScheduledTaskTrigger -AtStartup

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Clear Outlook Credentials" -Description "This scheduled task will clear any cached credentials with the mention of 'Microsoft' in the name upon starup"