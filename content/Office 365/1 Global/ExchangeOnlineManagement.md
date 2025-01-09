---
title: Exchange Online PowerShell Module
---
The ExchangeOnlineManagement module is used to connect to Exchange Online and run commands against objects in Exchange (Users, Groups, etc.)

## Prerequisites

### Install

Before you can connect to Exchange Online for the first time on a machine, you will need to install it. Here is the command to install it:

```PowerShell
Install-Module -Name ExchangeOnlineManagement
```

### Update

Occasionally, Microsoft will update the module, in that case, you can use the following command to update to the latest version of the module

```PowerShell
Update-Module -Name ExchangeOnlineManagement
```

### Import

Normally, you should not need to import it, it should import automatically when you run commands, but if you get an error about the command missing, you can try importing the module.

```PowerShell
Import-Module -Name ExchangeOnlineManagement
```

## Commands

### Connect with the Tenant's Global Admin

This will open a browser window for login. Use the global admin for the tenant you want to manage

```PowerShell
Connect-ExchangeOnline
```

### Connect Using Your Partner Access

This will open a browser window for login. Use your partner credentials to authenticate

```PowerShell
Connect-ExchangeOnline -DelegatedOrganization domain.onmicrosoft.com
```

## More Information

[Connect to Exchange Online PowerShell](https://learn.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell)

[ExchangePowerShell Module](https://learn.microsoft.com/en-us/powershell/module/exchange/)
