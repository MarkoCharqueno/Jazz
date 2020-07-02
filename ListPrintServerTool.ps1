#Add Network Printer from array


######################################
##                                  ##
#        VARIABLE DECLARATION        # 
##          non dynamic             ##
######################################


#PrintServer array
$Serverlist = @(Get-Content -Path "\\hqadapap38\packagesource$\Client Management\POWERSHELL\Dependencies\PrintServer.csv")


######################################
##                                  ##
#          ACTION FUNCTIONS          # 
##                                  ##
######################################



#PrintServer query
Function ListPrintServer
{
    
    $Printer = Read-Host "Enter Printer Name"

        Foreach ($Server in $Serverlist)
        {

        $A = Get-Printer -ComputerName $Server | Where {$_.Name -eq "$Printer"} | Select-Object -ExpandProperty ComputerName
        if ($A -ne $null) {break}

        }

        $script:ConnectionName = -Join ("\\", $A, "\", $Printer) -replace'[{}@]'
        
}


#Install printer remotely
Function InstallPrinter
{

Param([String]$Printer, [String]$Client)


        Foreach ($Server in $Serverlist)
        {

        $A = Get-Printer -ComputerName $Server | Where {$_.Name -eq $Printer} | Select-Object -ExpandProperty ComputerName
        if ($A -ne $null) {break}

        }

        $ConnectionName = "\\" +  $A + "\" + $Printer -replace'[{}@]'
        $Cmd = "RUNDLL32.EXE PRINTUI.DLL,PrintUIEntry /ga /z /n $ConnectionName /q"

        write-host $Cmd.GetType()
        write-host $A.GetType()
        write-host $Printer.GetType()
        write-host $Client.GetType()

 
        New-Item -Path \\$Client\C$\Temp\InstallPrinter.bat -ItemType "File" -Value $Cmd -Force
        Start-Process \\$Client\C$\Temp\InstallPrinter.bat -Wait
            If ($? -eq "False"){
                Write-Host "Error: $error[0]" -ForegroundColor Red    
            }
            Else{
                Write-Host "Installed Printer Successfuly!" -ForegroundColor Green
            }
        
}



######################################
##                                  ##
#            TOOL ACTIONS            # 
##                                  ##
######################################



#Loop script for possible infinite printers
Do 
{
    $UserInput = Read-Host '
    1: Get Print Server
    2: Install Remote Printer
    3: Exit
    
    Answer'

        #List print server of desired printer  
        If ($UserInput -eq 1){
            Write-Host "
            Get Print Server
            "
            #Call ListPrintServer function and display return
            ListPrintServer
            Write-Host $A
            
        }

        #Install Remote Printer
        If($UserInput -eq 2){
            Write-Host "
            Install Remote Printer
            "
            #Call InstallPrinter function
            $Printer = Read-Host "Enter Printer Name"

            $Client = Read-Host "Enter Computer Name"

            InstallPrinter($Printer, $Client)

                
        }

        #Exit Loop
        If ($UserInput -eq 3){
            Write-Host "
            Exiting...
            "
            break
        }


        
}
While($true)
Exit