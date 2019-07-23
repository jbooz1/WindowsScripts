# Audit all computers in a domain for any new services created in the last X amount of time

param(
	[int]$hour = 3
	)

# for each system in the domain, 
foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    $currenttime = Get-Date
    $hoursago = $currenttime.AddHours(0-$hour)  # have to add negative hours here to go back in time

    # check for any services that were created (event ID 7045)
    Get-WinEvent -ComputerName $computername -FilterHashtable @{`
                            logname='system';
                            id=7045;
                            StartTime=$hoursago} -ErrorAction SilentlyContinue `
                             | Format-List
}