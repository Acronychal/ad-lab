Import-Module ActiveDirectory

# Function AD groups based text file
function New-ADGroupsFromFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$path
    )

    $groups = Get-Content $path
    foreach ($group in $groups) {
        if (!(Get-ADGroup -Filter { Name -eq $group })) {
            New-ADGroup -Name $group -GroupScope Global
        }
    }
}

# Variables from data files
$firstNameFile = ".\resources\firstnames.csv"
$lastNameFile = ".\resources\surnames.csv"
$passwordFile = ".\resources\passwords.txt"
$domainGroupsFile = ".\resources\domain-groups.txt"

# User Prompts
$UserCount = Read-Host "How many user accounts do you want to create? "
$domainName = Read-Host "What is the lab domain name? "

# Create AD groups
New-ADGroupsFromFile -Path $domainGroupsFile

# Create user for loop engine
for ($i = 1; $i -le $UserCount; $i++) {
    $firstName = (Get-Content $firstNameFile | Get-Random).Trim()
    $lastName = (Get-Content $lastNameFile | Get-Random).Trim()
    $_password = (Get-Content $passwordFile | Get-Random).Trim()
    $domainGroup = (Get-Content $domainGroupsFile | Get-Random).Trim()
    $_username = ($firstName.Substring(0,1) + $lastName).ToLower()
    $password = ConvertTo-SecureString $_password -AsPlainText -Force

    Write-Host "Creating user: $($firstName) $($lastName) $($_password) $($domainGroup) $($_username)" -BackgroundColor Black -ForegroundColor Cyan 
    $output = $($firstname) + "," + $lastName + "," + $_password + "," + $domainGroup + "," + $_username
    out-file -filepath C:\Windows\Tasks\lab-key.csv -InputObject $output -Append

    # Define the user properties
    $userProperties = @{
        Name = ($firstName.Substring(0,1) + $lastName).ToLower()
        GivenName = $firstName
        Surname = $lastName
        DisplayName = $firstName + " " + $lastName
        UserPrincipalName = $firstName + "." + $lastName + "@" + $domainName
        AccountPassword = ConvertTo-SecureString $password -AsPlainText -Force
        Enabled = $true
        ChangePasswordAtLogon = $false
        # Set the sAMAccountName to the first initial of the first name and the last name
        SamAccountName = $_username
   
    }

    # Create account & add user to random group
    New-ADUser @userProperties
    Add-ADGroupMember -Identity $domainGroup -Members $userProperties.Name
        
    }