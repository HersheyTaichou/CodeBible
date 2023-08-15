# Azure Graph

Azure Graph is used to connect to Microsoft Azure AD, or Entra ID, then run commands against objects in Azure AD (Users, Groups, etc)

## Install the module

```PowerShell
Install-Module -Name Microsoft.Graph
```

## Update the module

```PowerShell
Update-Module -Name Microsoft.Graph 
```

## Import the module

Normally, you should not need to import it, it should import automatically when you run commands.

```PowerShell
Import-Module -Name Microsoft.Graph
```

## Connect to Microsoft Graph

```PowerShell
Connect-MgGraph –Scopes "User.ReadWrite.All", "Group.ReadWrite.All" -TenantID "domain.onmicrosoft.com"
```

Here is a link to a graph with a list of Azure AD cmdlets and the Graph counterparts.  
[Find Azure AD and MSOnline cmdlets in Microsoft Graph PowerShell](https://learn.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map)
