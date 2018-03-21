foreach($account in Get-ADUser -Filter *){
    $username = $account.SamAccountName
    foreach($system in Get-ADComputer -Filter *){
        $computername = $system.name
        $dir = "\\$computername\C$\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
        if(Test-Path $dir){
            ls $dir
        }
    }
}
