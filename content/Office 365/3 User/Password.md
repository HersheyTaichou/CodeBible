# Password Expiration Policies

## Prerequisites

Before running these commands, you will need to log in to [Microsoft Graph](../1%20Global/Microsoft.Graph.md) with the following scopes:

```PowerShell
Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"
```

## Commands

### Set the Password to Never Expire

```PowerShell
Update-MgUser -UserId <user ID> -PasswordPolicies DisablePasswordExpiration -PassThru
```

### Get the Current Password Policy

```PowerShell
Get-MGuser -UserId <user id or UPN> -Property UserPrincipalName, PasswordPolicies
```

## More Information

[Set an individual user's password to never expire](https://learn.microsoft.com/en-us/microsoft-365/admin/add-users/set-password-to-never-expire)
