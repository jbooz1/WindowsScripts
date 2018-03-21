foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    $currenttime = Get-Date
    $threehoursago = $currenttime.AddHours(-3)
    Get-WinEvent -ComputerName $computername -FilterHashtable @{`
                            logname='Security';
                            id=4698;
                            StartTime=$threehoursago} -ErrorAction SilentlyContinue `
                             | Format-List
}