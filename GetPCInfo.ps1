# This Powershell script takes a list of computers form a text file, pings them, and returns their OS name.  
# WinRM service needs to be running to read the Operating System name.
# April 2, 2019
# Josh Gold

#Forces script to follow Powershell best practices so I don't make too many dumb mistakes
Set-StrictMode -Version Latest

$MakeAnEmptyLine = echo `n  #For readability                                          

#Ping computers listed in specified test file and output their operating system name
Get-Content -Path C:\scripts\Powershell_Scripts\GetPCInfo\computers.txt | ForEach-Object { 
    if (Test-Connection -Computername $PsItem -Quiet -Count 1) {
        'The computer ' + $PsItem + ' is reachable.'                                                   
        
        $operating_system = Get-CimInstance -ComputerName $PsItem -ClassName 'Win32_OperatingSystem' | Select-Object Caption 
        'The computer named ' + $PsItem + ' has the operating system ' + $operating_system.Caption + '.'
        $MakeAnEmptyLine 
    }
}
