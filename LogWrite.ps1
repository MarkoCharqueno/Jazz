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
