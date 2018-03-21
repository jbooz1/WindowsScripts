foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    Get-WmiObject -Namespace root\subscription -Class __FilterToConsumerBinding -ComputerName `
        | Format-List -Property Path
}