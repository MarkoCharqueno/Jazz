#Upload OEM.Log to SharePoint
#Config Variables
$SiteURL = "https://chickasawnation.sharepoint.com/sites/ITCentralClientServices"
$FolderURL = 'Shared Documents/General/Imaging Process/Completed QA/' #Relative URL of the Parent Folder
$DateY = Get-Date | Select-Object -ExpandProperty Year
$DateM = Get-Date | Select-Object -ExpandProperty Month
$DateD = Get-Date | Select-Object -ExpandProperty Day
$FolderWD = -Join ($DateY, "/", $DateM, "/", $DateD)
$FolderName = -Join ($FolderURl, $FolderWD)


#Import neccessary resources
Install-Module SharePointPnPPowerShellOnline
Import-Module SharePointPnPPowerShellOnline


#Connect to Sharepoint
$Credentials = Get-Credential
Add-PnPStoredCredential -Name $SiteURL -Username $Credentials.UserName -Password $Credentials.Password
Connect-PnPOnline $SiteURl



#This does not work right now
Try { 
    #Create Folder if it doesn't exist
    Resolve-PnPFolder -SiteRelativePath $FolderName -Verbose | Wait-Job
    #Write-host "New Folder '$FolderName' Added!" -ForegroundColor Green -ErrorAction Stop
}
Catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}


#Upload log
$Log = Get-ChildItem "C:\Windows\BmcCache\Log_Files"
Try {
    #$File = $Files[0]
    Add-PnPFile -Folder $FolderName -Path $Log.FullName
    Write-Host "Log '$Log' Uploaded!" -ForegroundColor Green -ErrorAction Stop
}
Catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
#Read more: https://www.sharepointdiary.com/2016/08/sharepoint-online-create-folder-using-powershell.html#ixzz6OKPD8yJs