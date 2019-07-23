
# For each user in the domain, change the password of that user
foreach($user in Get-ADUser -Filter *){
    # Have to use Convert-ToSecureString here because Powershell doesn't like plaintext passwords to be on the command line
    Set-ADAccountPassword -Identity $user -NewPassword (ConvertTo-SecureString -String Password1! -AsPlainText -Force) -Reset
}