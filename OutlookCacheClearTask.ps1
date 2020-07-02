#Create a trigger 
$class = cimclass MSFT_TaskEventTrigger root/Microsoft/Windows/TaskScheduler
$trigger = $class | New-CimInstance -ClientOnly

#Enable Trigger and give it a definition based off of the event we want
$trigger.Enabled = $true 
$trigger.Subscription = '<QueryList><Query Id="0" Path="Security"><Select Path="Security">*[System[Provider[@Name="Microsoft-Windows-Security-Auditing"] and EventID=4738]]</Select></Query></QueryList>'


#Setup our TaskAction
$ActionParameters = @{
    Execute = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
    Argument = '-NoProfile -File C:\Users\Pi-\Documents\Tech stuff\Scrips\ClearOutlookCache.ps1'
}

#Set our Task Action
$Action = New-ScheduledTaskAction @ActionParameters
$Principal = New-ScheduledTaskPrincipal -UserId 'NT AUTHORITY\SYSTEM' -LogonType ServiceAccount
$Settings = New-ScheduledTaskSettingsSet

#Fill in Task parameters
$RegSchTaskParameters = @{
    TaskName    = 'Clear Outlook Credentials'
    Description = 'Run at account change'
    TaskPath    = '\Event Viewer Tasks\'
    Action      = $Action
    Principal   = $Principal
    Settings    = $Settings
    Trigger     = $Trigger
}

#Register created Task
Register-ScheduledTask @RegSchTaskParameters
