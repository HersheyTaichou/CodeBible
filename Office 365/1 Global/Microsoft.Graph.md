# Azure Graph

Azure Graph is used to connect to Microsoft Azure AD, or Entra ID, then run commands against objects in Azure AD (Users, Groups, etc)

## Prerequisites

### Install

Before you can connect to Microsoft Graph for the first time on a machine, you will need to install it. Here is the command to install it:

```PowerShell
Install-Module -Name Microsoft.Graph
```

### Update

Occasionally, Microsoft will update the module, in that case, you can use the following command to update to the latest version of the module

```PowerShell
Update-Module -Name Microsoft.Graph 
```

### Import

Normally, you should not need to import it, it should import automatically when you run commands, but if you get an error about the command missing, you can try importing the module.

```PowerShell
Import-Module -Name Microsoft.Graph
```

## Commands

### Connect to Microsoft Graph

Before you can run commands like Get-MgUser, you need to connect to a tenant. It will remember, or try to figure out, what tenant you want to connect to automatically, so I find it best to explicitly state which tenant to connect to.

When explicitly stating what tenant to connect to, you can use partner credentials to authenticate.

```PowerShell
Connect-MgGraph –Scopes "User.ReadWrite.All", "Group.ReadWrite.All" -TenantID "domain.onmicrosoft.com"
```

## More Information

Here is a link to a graph with a list of Azure AD cmdlets and the Graph counterparts.  
[Find Azure AD and MSOnline cmdlets in Microsoft Graph PowerShell](https://learn.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map)

[Microsoft Graph PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/microsoftgraph/)