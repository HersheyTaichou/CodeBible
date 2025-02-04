---
title: PowerShell Credential Vault
---

> PowerShell SecretManagement module provides a convenient way for a user to store and retrieve secrets. The secrets are stored in SecretManagement extension vaults. An extension vault is a PowerShell module that has been registered to SecretManagement, and exports five module functions required by SecretManagement. An extension vault can store secrets locally or remotely. Extension vaults are registered to the current logged in user context, and are available only to that user.  
> &mdash; [Microsoft.PowerShell.SecretManagement Module](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.secretmanagement/)

## Prerequisites

### Install the modules

```PowerShell
Install-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore
```

### Create a vault

```PowerShell
Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
```

## Commands

### Store creds in the vault

```PowerShell
$Creds = Get-Credential
Set-Secret -Name Client -Secret $Creds
```

### Connect with stored creds

This only works if they are not using modern authentication

```PowerShell
Connect-ExchangeOnline -Credential (Get-Secret -Name Client)
```

### Check existing stored creds

```PowerShell
Get-SecretInfo
```

## Resources

[Stop typing PowerShell credentials in demos using PowerShell SecretManagement](https://techcommunity.microsoft.com/t5/itops-talk-blog/stop-typing-powershell-credentials-in-demos-using-powershell/ba-p/2272072)

[Microsoft.PowerShell.SecretManagement Module](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.secretmanagement/)
