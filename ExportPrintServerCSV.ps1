#Logging function
$LogFile = 'C:\Automation and Innovation\Scheduled Tasks\Logs\PrintServer.log'
Add-Content -Path 'C:\Automation and Innovation\Scheduled Tasks\Logs\PrintServer.log' -Value (Get-Date) -Force
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

#Server array location
$Serverlist = @(Get-Content -Path "\\hqadapap38\packagesource$\Client Management\POWERSHELL\Dependencies\PrintServer.csv")

#Foreach loop 
#Cycles through each server gathering the necessary properties of interest
Foreach ($Server in $Serverlist)
{

Get-Printer -ComputerName $Server | Select-Object -Property Name, Comment, DriverName, Location, PortName, ShareName |
Export-Csv -Path C:\Users\marko.charqueno\Desktop\PrintersCSV\$Server.CSV -Force

}
LogWrite -LogSuccess "Successfully exported printerlist csv" -LogFail "Error: $($_.Exception.Message)"


#Upload to SharePoint
#SharePoint root URL
$URL = "https://chickasawnation.sharepoint.com/sites/ITCentralClientServices"

#First time tasks
#Install-Module SharePointPnPPowerShellOnline 
#$Creds = get-credential
#Creds to connect
Add-PnPStoredCredential -Name $URL -Username "Marko.Charqueno@Chickasaw.net" -Password $credential.Password

#Connect to SharePoint
Import-Module SharePointPnPPowerShellOnline 
Connect-PnPOnline $URL 

#Foreach loop For each csv in export path upload to SharePointPath
$Files = Get-ChildItem "C:\Users\marko.charqueno\Desktop\PrintersCSV"
foreach($File in $Files){
    #$File = $Files[0]
    Add-PnPFile -Folder "Shared Documents/General/Geeks and Nerds and Stuff/Printers" -Path $File.FullName
}
LogWrite -LogSuccess "Successsfully uploaded to SharePoint" -LogFail "Error: $($_.Exception.Message)"