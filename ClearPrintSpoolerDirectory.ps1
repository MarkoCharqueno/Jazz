#Clear print spool directory automated 




#prompt for credentials and stop the spooler service 


Get-Credential -Credential domain\user

Stop-Service -Name "spooler"


#Search for and kill printfilterpipelinesvc.exe which might prevent deletion of a few files

Get-Process | Where-Object { $_.Name -eq "printfilterpipelinesvc.exe" } | Select-Object -First 1 | Stop-Process


#Clear the print spool directory 

Get-ChildItem -Path C:\Windows\System32\spool\PRINTERS\*.* | Remove-Item -Force -Recurse -Confirm:$false | Out-Null

#Start the print spooler service 

Start-Service -Name "Spooler" 


#Profit
