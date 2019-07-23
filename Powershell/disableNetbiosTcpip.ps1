# Script to disable NetBIOS over TCP for every computer in the domain

# for each computer in the domain, 
foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    $adapters = Get-WmiObject -ComputerName $computername Win32_NetworkAdapterConfiguration
   
    # turn off netbios over tcp for every network adapter
    foreach($adapter in $adapters){
        if($adapter.IPAddress -ne $null){
            $adapter.SetTcpipNetbios(2)
        }
    }
}