---
title: Password Expiration Policies
---

This article includes commands for managing password expiration policies in Entra ID

## Prerequisites

Before running these commands, you will need to connect to the [[Microsoft.Graph|Microsoft Graph PowerShell Module]] with the following scopes:

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
