# Change the permissions on each file in the startup directory for every user and computer in the domain
# Note that the startup location might be different than listed here

foreach($account in Get-ADUser -Filter *){
    $username = $account.SamAccountName
    foreach($system in Get-ADComputer -Filter *){
        $computername = $system.name
        try{
            $dir = "\\$computername\C$\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
            if(-not (Test-Path $dir)){
                throw("Directory does not exist")
            }
            $directoryACL = Get-Acl $dir
            
            # This is the line that does the magic
            # The example given below will give Everyone NO permissions to create files
            # This means that nobody can create any files
            # This will also log audit successes, meaning that it will log if somone does create a file
            # For more info: https://docs.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.filesystemauditrule?view=netframework-4.8
            $accessrule = New-Object System.Security.AccessControl.FileSystemAuditRule(`
                                        "Everyone", "CreateFiles", "none", "Success")
            $directoryACL.AddAuditRule($accessrule)
            Get-ChildItem $dir
        } 
        catch{
            #Failure can mean that the host is off or the dir does not exist (user has not logged on)
        }
    }
}