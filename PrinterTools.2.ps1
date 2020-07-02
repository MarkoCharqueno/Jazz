#Printer Tools

#Server array location 
$Serverlist = @(Get-Content -Path "\\hqadapap38\packagesource$\Client Management\POWERSHELL\Dependencies\PrintServer.csv")

#Start variables
$PrinterName = ""
$ComputerName = ""
$Cmd = ""

function ListPrintServer {
    <#
    .SYNOPTIS 
        Writes host server of printer to host.
    .DESCRIPTION
        The ListPrintServer cmdlet will write the host server of a specified printer to the host console. 
    #>
    
    $Printer = Read-Host "Enter Printer Name"
    $i=1
    foreach ($Server in $Serverlist) {
        $i++
        $A = Get-Printer -ComputerName $Server | Where {$_.Name -eq $Printer} | Select-Object -ExpandProperty ComputerName
            if ($A -ne $null) {
                break
            }
            elseif($i -gt 15) {
                Write-Host "
                Unable to locate print server
                Please check printer name and try again
                " -ForegroundColor Red
            }
    }
return $A
}
 

#Remote install printer function
#List print server function with the addition of packaging the necessary strings in a .bat then calling the .bat
function InstallPrinter {
    $Printer = Read-Host "Enter Printer Name"

        foreach ($Server in $Serverlist) {
            $A = Get-Printer -ComputerName $Server | Where {$_.Name -eq $Printer} | Select-Object -ExpandProperty ComputerName
            if ($A -ne $null) {break}
        }

    #Necessary string to install printer for all users
    $Cmd = "RUNDLL32.EXE PRINTUI.DLL,PrintUIEntry /ga /z /n " + "\\" + $A + "\" + $Printer + " /q"

    #This is what was necessary to circumvent using the wimrm service
    #Wimrm service would only accept connections half of the time

    $Client = Read-Host "Enter Computer Name"
    New-Item -Path \\$Client\C$\Temp\InstallPrinter.bat -Force
    Add-Content \\$Client\C$\Temp\InstallPrinter.bat $Cmd
    
    Psexec \\$Client C:\Temp\InstallPrinter.bat

    Start-Sleep -Seconds 5
    Remove-Item -Path \\$Client\C$\Temp -Force -Recurse
}

#User selection 
Do {
    $UserInput = Read-Host '
    1: Get Print Server
    2: Remote Install Printer
    3: Exit
    
    Answer'

        # List print server of desired printer  
        if ($UserInput -eq 1){
            Write-Host "
            Get Print Server
            "
            #Call ListPrintServer function and display return
            $A = ListPrintServer
            Write-Host "
            $A" -ForegroundColor Green        
        }

        # Install Remote Printer
        if($UserInput -eq 2){
            Write-Host "
            Remote Install Printer
            "
            InstallPrinter              
        }

        # Exit Loop
        if ($UserInput -eq 3){
            Write-Host "
            Exiting...
            "
            break
        }
}
while($true)
Exit