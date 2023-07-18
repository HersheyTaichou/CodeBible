# SharePoint Online

SharePoint online is used to connect to SharePoint online then run commands against objects in SharePoint

## Install the module

```PowerShell
Install-Module -Name Microsoft.Online.SharePoint.PowerShell
```

## Update the module

```PowerShell
Update-Module -Name Microsoft.Online.SharePoint.PowerShell 
```

## Import the module

Normally, you should not need to import it, it should import automatically when you run commands.

```PowerShell
Import-Module -Name Microsoft.Online.SharePoint.PowerShell
```

## Connect to SPO

```PowerShell
Connect-SPOService -Url https://contoso-admin.sharepoint.com
```

If you get an error telling you to use Modern Authentication, try the following:

```PowerShell
Connect-SPOService -Credential $creds -Url https://tenant-admin.sharepoint.com -ModernAuth $true -AuthenticationUrl https://login.microsoftonline.com/organizations
```

Source: [Connect to SharePoint online](https://learn.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online)
