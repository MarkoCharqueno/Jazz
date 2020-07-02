Function LogCreate
{
param ([string]$CreatePath)
    New-Item -Path $CreatePath -Force
    $Logfile = $CreatePath
    $DateTime = Get-Date
    Set-Content -Path $LogFile -Value "Starting OEM Setup:  $DateTime"
}


<#
Example:

LogCreate C:\Users\marko.charqueno\Desktop\logtestfolder\test.txt

#>



Function LogWrite
{
    param ([string]$LogSuccess, [string]$LogFail)
    if ($? -eq "True")
        {
        Add-content -path $LogFile -value "$LogSuccess"
        }
    else
        {
        Add-Content -Path $LogFile -Value "$LogFail"
        }
}


<#
Example:

$Logfile = "C:\Users\Tech\Desktop\LogFile.txt"

New-Item -ItemType Directory -Path "C:\Users\Tech\Desktop\Test" -Force

LogWrite -LogSuccess "This is a test" -LogFail "This is also a test"
#>