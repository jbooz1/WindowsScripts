foreach($account in Get-ADUser -Filter *){
    $username = $account.SamAccountName
    foreach($system in Get-ADComputer -Filter *){
        $computername = $system.name
        try{
            $dir = "\\$computername\C$\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
            if(-not (Test-Path $dir)){
                throw("Directory does ont exist")
            }
            $directoryACL = Get-Acl $dir
            $accessrule = New-Object System.Security.AccessControl.FileSystemAuditRule(`
                                        "Everyone", "CreateFiles", "none", "Success")
            $directoryACL.AddAuditRule($accessrule)
            ls $dir
        } 
        catch{
            #Failure can mean that the host is off or the dir does not exist (user has not logged on)
        }
    }
}