# PowerShell Credential Vault

## Install the modules

```PowerShell
Install-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore
```

## Create the vault

```PowerShell
Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
```

## Store creds in the vault

```PowerShell
$Creds = Get-Credential
Set-Secret -Name Client -Secret $Creds
```

## Connect with stored creds

This only works if they are not using modern authentication

```PowerShell
Connect-ExchangeOnline -Credential (Get-Secret -Name Client)
```

## Check existing stored creds

```PowerShell
Get-SecretInfo
```

## Resources

[](https://techcommunity.microsoft.com/t5/itops-talk-blog/stop-typing-powershell-credentials-in-demos-using-powershell/ba-p/2272072)
[](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.secretmanagement/)
