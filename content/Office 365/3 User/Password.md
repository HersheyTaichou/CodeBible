---
title: Password Expiration Policies
---

This article includes commands for managing password expiration policies in Entra ID

## Prerequisites

These commands require the #Microsoft_Graph module with the `User.ReadWrite.All` and `Group.ReadWrite.All` scopes.

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
