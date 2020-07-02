#  Add Network Printer from array

#  PrintServer array
$Serverlist = @(Get-Content -Path "\\hqadapap38\packagesource$\Client Management\POWERSHELL\Dependencies\PrintServer.csv")

#  PrintServer query
Function ListPrintServer
{

    $Printer = Read-Host "Enter Printer Name"

        Foreach ($Server in $Serverlist)
        {

        $A = Get-Printer -ComputerName $Server | Where {$_.Name -eq "$Printer"} | Select-Object -ExpandProperty ComputerName
        if ($A -ne $null) {break}

        }

    Write-Host $A

}


#  Loop script for possible infinite printers
Do 
{
    $UserInput = Read-Host '
    1: Get Print Server
    2: Exit
    
    Answer'

        If ($UserInput -eq 1){
            Write-Host "
            Get Print Server
            "
            ListPrintServer
            
    
        }

        If ($UserInput -eq 2){
            Write-Host "
            Exiting...
            "
            break
        }

}
While($true)
Exit