import-module servermanager


$Zones = @(Get-DnsServerZone)
ForEach ($Zone in $Zones) {
	Write-Host "`n$($Zone.ZoneName)" -ForegroundColor "Green"
	$Zone | Get-DnsServerResourceRecord
	$Results = $Zone | Get-DnsServerResourceRecord -ComputerName $DNSServer
	echo $Results > "$($Zone.ZoneName).txt"
}




Get-WindowsFeature –ComputerName Server01 | Where Installed | remove-windowsfeature $_ 


stop-computer


