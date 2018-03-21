foreach($user in Get-ADUser -Filter *){
    Set-ADAccountPassword -Identity $user -NewPassword (ConvertTo-SecureString -String Password1! -AsPlainText -Force) -Reset
}