# This utility prompts the user and creates a domain based on input
# Prompt
$domainName = Read-Host -Prompt 'Enter the domain name '

# Setup Variables
$databasePath = 'C:\Windows\NTDS'
$domainMode = 'WinThreshold'
$domainNetbiosName = $domainName.Split('.')[0].ToUpper()
$forestMode = 'WinThreshold'
$installDns = $true
$logPath = 'C:\Windows\NTDS'
$noRebootOnCompletion = $false
$sysvolPath = 'C:\Windows\SYSVOL'
$force = $true

# Install ADDS Forest
Import-Module ADDSDeployment
Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath $databasePath `
    -DomainMode $domainMode `
    -DomainName $domainName `
    -DomainNetbiosName $domainNetbiosName `
    -ForestMode $forestMode `
    -InstallDns $installDns `
    -LogPath $logPath `
    -NoRebootOnCompletion $noRebootOnCompletion `
    -SysvolPath $sysvolPath `
    -Force $force