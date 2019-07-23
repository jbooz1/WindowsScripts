<#
.SYNOPSIS
This script will move AD Computer objects into or out of a specified OU.
The default is to move 50% of the computers to that OU at random, but you can
also pass in a file with a list of computers you wish to move, specify a custom 
percentage or specify an exact number.
This was built for an exercise so the random factor was desired. Randomness is not required.

.PARAMETER ou
The OU that you would like to move computer objects into

.PARAMETER file
File that contains computers which are to move to the new OU
This should be one computer name per line

.PARAMETER remove
Set this boolean parameter to remove Computers from the OU instead of add them to the OU.
If remove is used with a file, then those listed computers will be removed from any OUs and 
placed in the generic 'Computers' container.
If remove is used without a file, then all computers in the specified OU are removed from the OU
and placed in the generic 'Computers' container.

The defualt is to add computers to the specified OU

.PARAMETER percent
Set this parameter if you wish to move a random percentage of the computers in a Domain to an OU.
Pass in as an INT.
Example pass in 25 for this parameter to move 25% of the computers to the OU

.PARAMETER number
Set this parameter to move an exact number of computers to an OU.
#>
Param(
    [Parameter(Mandatory=$true)][String]$ou,
    [Parameter(Mandatory=$false)][String]$file,
    [Parameter(Mandatory=$false)][bool]$remove=$false,
    [Parameter(Mandatory=$false)][int]$percent=50,
    [Parameter(Mandatory=$false)][int]$number
)


function  Get-RandomNumbers{
    <#
    .SYNOPSIS
    Generates *count* different random numbers in a range from 0 to Max. 
    Returns an array of these values
    #>

    param (
        [Parameter(Mandatory=$true)][int]$count,
        [Parameter(Mandatory=$true)][int]$max
    )

    # error checking
    if($count -gt $max){
        Write-Error "Count cannot be greater than max"
        return
    }

    $rands = @()  # init array of randoms

    # Generate a new random number *count* times
    for($i = 0; $i -lt $count; $i++){

        # generate a number that is not already in the list
        $n = Get-Random -Minimum 0 -Maximum $max
        while($n -in $rands){
            $n = Get-Random -Minimum 0 -Maximum $max
        }

        $rands += $n   # add random number to the list
    }
    return $rands
}

$computers = @()  # init array of computers

# if a file is specified, add all computers in that file to the list
if($file){
    get-content -path $file | ForEach-Object {
        $computers += Get-AdComputer -Filter "Name -like `"$_`""
    }

}

# if no file is specified and remove is not specified, then we should generate a random list of computers
elseif (!$remove){
    $all = Get-AdComputer -filter *

    # if a specific number is not given, then use a percentage of the total computers in the domain
    if(!$number){
        $number = [int]($all.count*($percent/100))  # calc a percantage of the total number of computers
    }

    $number = [Math]::Min($number, $all.count)  # make sure to not generate more numbers than computers
    $indexes = Get-RandomNumbers -count $number -max $all.count

    # add each random index from all computers to the list of computers we wish to move
    foreach($i in $indexes){
        $computers += $all[$i]
    }

    # set the move-to target to the desired OU
    $target = Get-AdOrganizationalUnit -Filter "Name -like `"$ou`""
}

# no file specified and remove is set.
# Must get objects from a specific OU to remove them all
else{
     # get all computers in an OU
    $sb = Get-AdOrganizationalUnit -Filter "Name -like `"$ou`""
    $computers = Get-AdComputer -Filter * -Searchbase $sb  

    # Set the move-to target to be the generic computers container
    $target = get-AdObject -Filter 'Name -like "Computers"'
}

Write-Host "COMPUTERS TO MOVE"
$computers

# move all computers in the array to the target
foreach($computer in $computers){
    Move-AdObject -Identity $computer -TargetPath $target
}