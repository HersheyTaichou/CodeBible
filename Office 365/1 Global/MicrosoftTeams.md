# Microsoft Teams

The MicrosoftTeams module is used to connect to Teams Online and run commands against Teams or manage user's access


## Prerequisites

### Install

Before you can connect to Teams Online for the first time on a machine, you will need to install the module. Here is the command to install it:

```PowerShell
Install-Module -Name MicrosoftTeams
```

### Update

Occasionally, Microsoft will update the module, in that case, you can use the following command to update to the latest version of the module

```PowerShell
Update-Module -Name MicrosoftTeams
```

### Import

Normally, you should not need to import it, it should import automatically when you run commands, but if you get an error about the command missing, you can try importing the module.

```PowerShell
Import-Module -Name MicrosoftTeams
```

## Commands

### Connect with the Tenant's Global Admin

This will open a browser window for login. Use the global admin for the tenant you want to manage

```PowerShell
Connect-MicrosoftTeams
```

### Connect Using Your Partner Access

This will open a browser window for login. Use your partner credentials to authenticate

```PowerShell
Connect-MicrosoftTeams -TenantID domain.onmicrosoft.com
```

## More Information

[Install Microsoft Teams PowerShell Module](https://learn.microsoft.com/en-us/microsoftteams/teams-powershell-install)

[MicrosoftTeamsPowerShell Module](https://learn.microsoft.com/en-us/powershell/module/teams)
