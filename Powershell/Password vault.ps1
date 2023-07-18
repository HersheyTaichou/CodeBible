#Create vault
Install-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore
Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault

# store creds in vault
$Creds = Get-Credential
Set-Secret -Name Client -Secret $Creds

# connect with stored creds
## This only works if they are not using modern authentication
Connect-ExchangeOnline -Credential (Get-Secret -Name Client)

# Check existing stored creds:
Get-SecretInfo

#resources:
#	https://techcommunity.microsoft.com/t5/itops-talk-blog/stop-typing-powershell-credentials-in-demos-using-powershell/ba-p/2272072
#	https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.secretmanagement/?view=ps-modules
