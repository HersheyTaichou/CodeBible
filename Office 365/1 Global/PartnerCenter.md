# PartnerCenter

The PartnerCenter module is used to connect to the Microsoft Partner portal in PowerShell to run reports or gather information about customer tenants

## Prerequisites

### Install

Before you can connect to the partner portal for the first time on a machine, you will need to install the module. Here is the command to install it:

```PowerShell
Install-Module -Name PartnerCenter
```

### Update

Occasionally, Microsoft will update the module, in that case, you can use the following command to update to the latest version of the module

```PowerShell
Update-Module -Name PartnerCenter
```

### Import

Normally, you should not need to import it, it should import automatically when you run commands, but if you get an error about the command missing, you can try importing the module.

```PowerShell
Import-Module -Name PartnerCenter
```

## Commands

### Connect Using Your Partner Access

This will open a browser window for login. Use your partner credentials to authenticate

```PowerShell
Connect-PartnerCenter
```

### Get a List of Partner Customers

This can be useful if you want to check what a customer's Tenant ID is when logging in with other modules using your Partner access.

```PowerShell
Get-PartnerCustomer
```

## More Information

[PartnerCenter Module](https://learn.microsoft.com/en-us/powershell/module/partnercenter/)
