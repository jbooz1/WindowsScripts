param(
	[int]$hour = 0,
	[int]$minute = 30
	)
$current = get-date
$start = $current.AddHours(-1*$hour).AddMinutes(-1*$minute)
Get-EventLog -logname Security -after $start -InstanceId 4720