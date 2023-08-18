# SharePoint Online

The Microsoft.Online.SharePoint.PowerShell module is used to connect to SharePoint Online and then run commands against objects in SharePoint

## Prerequisites

### Install

Before you can connect to SharePoint Online for the first time on a machine, you will need to install it. Here is the command to install it:

```PowerShell
Install-Module -Name Microsoft.Online.SharePoint.PowerShell
```

### Update

Occasionally, Microsoft will update the module, in that case, you can use the following command to update to the latest version of the module

```PowerShell
Update-Module -Name Microsoft.Online.SharePoint.PowerShell 
```

### Import

Normally, you should not need to import it, it should import automatically when you run commands, but if you get an error about the command missing, you can try importing the module.

```PowerShell
Import-Module -Name Microsoft.Online.SharePoint.PowerShell
```

## Commands

### Connect to SPO

Update the URL to the Tenant's admin SharePoint site

```PowerShell
Connect-SPOService -Url https://contoso-admin.sharepoint.com
```

If you get an error telling you to use Modern Authentication, try the following:

```PowerShell
Connect-SPOService -Credential $creds -Url https://tenant-admin.sharepoint.com -ModernAuth $true -AuthenticationUrl https://login.microsoftonline.com/organizations
```

## More Information

[Connect to SharePoint Online](https://learn.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online)
