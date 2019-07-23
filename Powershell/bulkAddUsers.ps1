# Easy Bulk User Add Script
# Check to make sure the CSV has the required fields or change the fields to what you want
# CSV should have headers in it

$csv = Import-Csv 'INSERT LOCATION OF FILE HERE IN SINGLE QUOTES'
$csv


foreach($line in $csv){
    # Saving some vars for later
    $samaccountname = $line.username
    $OU = $line.Role
    $password = $line.Password

    # From the Active Directgory Module. 
    # See this link for more info on the module https://docs.microsoft.com/en-us/powershell/module/addsadministration/?view=win10-ps
    New-ADUser -name $line.'First name' -SamAccountName $samaccountname -Path "OU=$OU,DC=INSERT (CORP/SALES/PRODUCTION) HERE,DC=team1,DC=tu" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PasswordNeverExpires $true -Enabled $true

}