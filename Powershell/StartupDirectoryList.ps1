# List the contents of the startup directory for all computers and all users in the domain
# Note that the startup location might be different than listed here

foreach($account in Get-ADUser -Filter *){
    $username = $account.SamAccountName
    foreach($system in Get-ADComputer -Filter *){
        $computername = $system.name
        $dir = "\\$computername\C$\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
        if(Test-Path $dir){
            Get-ChildItem $dir
        }
    }
}
