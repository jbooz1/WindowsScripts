# This should detect new users that were created within the last x amount of time

# Params that this takes with defaults set to find new users in the last 30 min
param(
	[int]$hour = 0,
	[int]$minute = 30
	)
$current = get-date
$start = $current.AddHours(-1*$hour).AddMinutes(-1*$minute)
Get-EventLog -logname Security -after $start -InstanceId 4720  # 4720 is the user created event log ID