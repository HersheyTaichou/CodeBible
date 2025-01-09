---
title: AzureAD PowerShell Module
---
>[!Deprecated] The #AzureAD module is planned for  deprecation and is is superseded by #Microsoft_Graph.

The #AzureAD module is used to connect to Entra ID (formerly Azure AD) and run commands against objects in Entra ID (Users, Groups, etc).

>[!Powershell5] The AzureAD module only works in Windows PowerShell, and will generate errors if you try to use it in PowerShell Core

## Prerequisites

### Install

Before you can connect to Entra ID for the first time on a machine, you will need to install the module. Here is the command to install it:

```PowerShell
Install-Module -Name AzureAD
```

### Update

Occasionally, Microsoft will update the module, in that case, you can use the following command to update to the latest version of the module

```PowerShell
Update-Module -Name AzureAD
```

### Import

Normally, you should not need to import it, it should import automatically when you run commands, but if you get an error about the command missing, you can try importing the module.

```PowerShell
Import-Module -Name AzureAD
```

If you want to use the commands in PowerShell Core on a Windows machine, you need to tell it to load the module in Windows PowerShell.

```PowerShell
Import-Module -Name AzureAD -UseWindowsPowerShell
```

Note, you will have to have installed the module in Windows PowerShell previously for it to load it.

## Commands

### Connect with a Tenant's Global Admin

This will open a browser window for login. Use the global admin for the tenant you want to manage

```PowerShell
Connect-AzureAD
```

### Connect Using a Partner Account

This will open a browser window for login. Use your partner credentials to authenticate

```PowerShell
Connect-AzureAD -TenantId domain.onmicrosoft.com
```

## More Information

[AzureAD Module](https://learn.microsoft.com/en-us/powershell/module/azuread/)
