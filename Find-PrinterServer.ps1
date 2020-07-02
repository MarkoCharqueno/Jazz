<#
.SYNOPSIS
    Retrieves a printers host print server, can install printer on remote clients if selected. 

.DESCRIPTION

   Will provide a console screen with the following options.

   1. Get Printer Server -Retrive the host print server of a specified printer.

   2. Install Printer -Retriev the host print server of a specified printer as well as installing the printer on one or more specified remote clients.

   3. Exit -Exits tool.

   This tool will continue to loop until exited

.EXAMPLE

   PS C:\> C:\PrinterTools3.ps1

    1: Get Printer Server
    2: Install Printer
    3: Exit
    
    Answer: 1
Enter Printer Name: P-ADA-ASA-IT01

 ADAVPS01

    1: Get Printer Server
    2: Install Printer
    3: Exit
    
    Answer:

.EXAMPLE

    PS F:\> C:\> C:\PrinterTools3.ps1

    1: Get Printer Server
    2: Install Printer
    3: Exit
    
    Answer: 2
Enter Printer Name: P-ADA-ASA-IT01

 Found P-ADA-ASA-IT01 on ADAVPS01 

Enter Client Name: CN00009010


    Directory: \\CN00009010\C$\Temp


Mode                LastWriteTime         Length Name                                                                                                                                                                                                            
----                -------------         ------ ----                                                                                                                                                                                                            
-a----        6/30/2020   3:20 PM              0 InstallPrinter.bat                                                                                                                                                                                              

PsExec v2.2 - Execute processes remotely
Copyright (C) 2001-2016 Mark Russinovich
Sysinternals - www.sysinternals.com

psexec : C:\Temp\InstallPrinter.bat exited with error code 0.
At C:\Users\marko.charqueno\OneDrive - the Chickasaw Nation\Jazz\Jazz\Printers\PrinterTools3.ps1:65 char:13
+             psexec \\$Computer C:\Temp\InstallPrinter.bat
+             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (C:\Temp\Install...h error code 0.:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 

    1: Get Printer Server
    2: Install Printer
    3: Exit
    
    Answer: 
#>

function Find-PrinterServer {
    [CmdletBinding()]
    param([Parameter()]
    [switch]$Client)

    Begin {
        $i = 1
        $serverlist = Get-Content -Path "\\hqadapap38\packagesource$\Client Management\POWERSHELL\Dependencies\PrintServer.csv"
        $printer = Read-Host "Enter Printer Name"
    }
    Process {
        foreach ($server in $serverlist) {
            $i++
            $a = Get-Printer -ComputerName $server | Where {$_.Name -eq $printer} | Select-Object -ExpandProperty ComputerName
            if($i -gt 15) {
                $print = "`n " + "Unable to locate print server" + "`n " + "Please check printer name and try again"           
                Write-Host $print -ForegroundColor Red
                break
            }
            if ($a -ne $null) {
                Write-Host "`n" "Found $printer on" $a "`n" -ForegroundColor Green | Select-Object -First 1 # Will pull server twice otherwise 
                break
            }
        }
        if (($Client.IsPresent) -and ($i -ile 15)) {
            # Necessary to circumvent Wimrm service
            $Cmd = "RUNDLL32.EXE PRINTUI.DLL,PrintUIEntry /ga /z /n " + "\\" + $a + "\" + $printer + " /q"
            $Computer = Read-Host "Enter Client Name"
            New-Item -Path \\$Computer\C$\Temp\InstallPrinter.bat -Force -ErrorAction SilentlyContinue
            Add-Content \\$Computer\C$\Temp\InstallPrinter.bat $Cmd -ErrorAction SilentlyContinue
            psexec \\$Computer C:\Temp\InstallPrinter.bat
            Start-Sleep -Seconds 5
            Remove-Item -Path \\$Computer\C$\Temp -Force -Recurse -ErrorAction SilentlyContinue
        }
    }
}


Do {
    $userinput = Read-Host '
    1: Get Printer Server
    2: Install Printer
    3: Exit
    
    Answer'

    # List print server  
    if ($UserInput -eq 1){
        Find-PrinterServer
    }
    # List print server and install printer
    if($UserInput -eq 2){
        Find-PrinterServer -Client
    }
    # Exit Loop
    if ($UserInput -eq 3){
        Write-Host "
        Exiting...
        "
        exit
    }
}
while($true)