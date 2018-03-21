foreach($system in Get-AdComputer -Filter *){
    $computername = $system.name
    $adapters = Get-WmiObject -ComputerName $computername Win32_NetworkAdapterConfiguration
    foreach($adapter in $adapters){
        if($adapter.IPAddress -ne $null){
            $adapter.SetTcpipNetbios(2)
        }
    }
}