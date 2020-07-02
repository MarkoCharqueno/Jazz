Write-Host "Installing Updates" "`n" "Please do Not Reboot"

Import-Module "\\hqadapap38\packagesource$\Client Management\POWERSHELL\PSModules\PSWindowsUpdate"

Get-WUInstall -AcceptAll -IgnoreRebootRequired -Verbose

Write-Host "Updates Have Been Downloaded" "`n" "Please Reboot for Updates to Apply"