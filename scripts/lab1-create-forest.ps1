# This utility prompts the user and creates a domain based on input
# Prompt
$domainName = Read-Host -Prompt 'Enter the domain name '
$domainNetbiosName = $domainName.Split('.')[0].ToUpper()

# Install ADDS Forest
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName $domainName `
-DomainNetbiosName $domainNetbiosName `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true