# Import the Active Directory module
Import-Module ActiveDirectory

# Define the paths to account data files
$firstNameFile = ".\resources\firstnames.csv"
$lastNameFile = ".\resources\surnames.csv"
$passwordFile = ".\resources\passwords.txt"
$domainGroupsFile = ".\resources\domain-groups.txt"

# Prompt the user for the number of users to create
$UserCount = Read-Host "How many user accounts do you want to create? "

# Loop based on user input
for ($i = 1; $i -le $UserCount; $i++) {
    $firstName = (Get-Content $firstNameFile | Get-Random).Trim()
    $lastName = (Get-Content $lastNameFile | Get-Random).Trim()
    $password = (Get-Content $passwordFile | Get-Random).Trim()
    $domainGroup = (Get-Content $domainGroupsFile | Get-Random).Trim()
    Write-Host "Creating user: $($firstName)" -BackgroundColor Black -ForegroundColor Cyan

    # Define the user properties
    $userProperties = @{
        Name = $firstName + "." + $lastName
        GivenName = $firstName
        Surname = $lastName
        DisplayName = $firstName + " " + $lastName
        UserPrincipalName = $firstName + "." + $lastName + "@arconyhcal.dev"
        AccountPassword = ConvertTo-SecureString $password -AsPlainText -Force
        Enabled = $true
        ChangePasswordAtLogon = $false
        SamAccountName = ($firstName.Substring(0,1) + $lastName).ToLower()
    }

    # Create the user account in Active Directory
    New-ADUser @userProperties

    # Add the user to the random domain group
    Add-ADGroupMember -Identity $domainGroup -Members $userProperties.Name
}