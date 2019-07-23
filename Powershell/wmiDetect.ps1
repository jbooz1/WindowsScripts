# Will list WMI subscriptions on all computers in the domain

foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    Get-WmiObject -Namespace root\subscription -Class __FilterToConsumerBinding -ComputerName $computername `
        | Format-List -Property Path
}