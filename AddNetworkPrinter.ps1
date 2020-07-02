#  Add Network Printer from array

#  Declare our variables
#  Prompt for computer name and printer
$Printer = Read-Host "Enter Printer Name"
$Client = Read-Host "Enter Computer Name"

#  PrintServer array
$Serverlist = @(Get-Content -Path "\\hqadapap38\packagesource$\Client Management\POWERSHELL\Dependencies\PrintServer.csv")

#  Format our print server query 
$ConnectionName = -Join ("\\", "$A", "\", "$Printer") -replace'[{}@]'

#  Command that will install printer on $Client
$Cmd = "RUNDLL32.EXE PRINTUI.DLL,PrintUIEntry /ga /z /n $ConnectionName /q"

#  PrintServer query
Foreach ($Server in $Serverlist)
{

$A = Get-Printer -ComputerName $Server | Where {$_.Name -eq "$Printer"} | Select-Object -ExpandProperty ComputerName
if ($A -ne $null) {break}

} 

#  Make script on $Client to install printer
New-Item -Path \\$Client\C$\Temp\InstallPrinter.bat -ItemType "File" -Value $Cmd -Force
Start-Process \\$Client\C$\Temp\InstallPrinter.bat -Wait
Remove-Item \\$Client\C$\Temp -Force


<#
Invoke-Command -ScriptBlock {RUNDLL32.EXE PRINTUI.DLL,PrintUIEntry /ga /z /n "$ConnectionName" /q} -ComputerName $Client 
if ($? -eq "True"){
    Write-Host "Installing printer..."
}else{
    Write-Host "Failed to install printer! Failed to connect or printer name invalid"
}
#>


#Testbox for easy reference DCL-7XZ6PN2