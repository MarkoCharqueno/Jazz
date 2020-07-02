Function LogCreate
{
param ([string]$CreatePath)
    New-Item -Path $CreatePath -Force
    $Logfile = $CreatePath
    $DateTime = Get-Date
    Set-Content -Path $LogFile -Value "Starting OEM Setup:  $DateTime"
}

LogCreate C:\Users\marko.charqueno\Desktop\logtestfolder\test.txt