# Get Details about Guest Users

This article goes over how to gather details on guest users in Entra ID

## Prerequisites

Before running these commands, you will need to connect to [Microsoft Graph](../1%20Global/Microsoft.Graph.md) with the following scopes

```PowerShell
Connect-MgGraph -Scopes "Directory.Read.All,AuditLog.Read.All"
```

## Commands

### Creation and Last Login Date

This command will gather all the guest users in the tenant and include some additional properties

```PowerShell
$GuestUsers = Get-MgUser -All -Filter "UserType eq 'Guest'" -Property 'UserPrincipalName','SignInActivity','Mail','DisplayName','CreatedDateTime'
```

This command will export a report with the above details

```powershell
$GuestUsers | Select-Object Mail,UserPrincipalName,DisplayName,Id,@{N='LastSignInDate';E={$_.SignInActivity.LastSignInDateTime}},CreatedDateTime | Export-Csv "$env:TEMP\GuestUsers.csv"
```

## More Information

[Source](https://stackoverflow.com/collectives/azure/articles/75885876/how-to-retrieve-the-last-sign-in-date-time-for-all-users-in-azure-ad-using-micro)
