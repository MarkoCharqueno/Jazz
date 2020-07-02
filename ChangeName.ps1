$LogFile = "C:\Windows\BmcCache\Log_Files\OEM.log"

#Delete from desktop
Remove-Item 'C:\Users\Public\Desktop\ChangeName.bat' -Force
if($? -eq "True")
    {
    Add-Content -Path $LogFile -Value "Removed ChangeName script from Public Desktop"
    }
else 
    {
    Add-Content -Path $LogFile -Value "Failed to remove ChangeName script from Public Desktop"
    }


#  Enter new computer Name
$newName = Read-Host -prompt 'Input new computer name here'
if ($? -eq "True")
    {
    add-content -path $LogFile -value "The Computer name has been set to $NewName"
    }

$Credentials = Get-Credential
Write-Host "preparing to Reboot!"
Start-Sleep -Seconds 5
Rename-Computer -NewName $newName -Force -DomainCredential $Credentials -Restart
