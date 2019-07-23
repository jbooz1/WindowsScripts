# Audit each system in domain for new scheduled tasks that were created in the last x time

param(
	[int]$hour = 3
	)

# For each system in domain, 
foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    $currenttime = Get-Date
    $hoursago = $currenttime.AddHours(0-$hours)

    # Query event log for event ID 4698, new scheduled task
    Get-WinEvent -ComputerName $computername -FilterHashtable @{`
                            logname='Security';
                            id=4698;
                            StartTime=$hoursago} -ErrorAction SilentlyContinue `
                             | Format-List
}