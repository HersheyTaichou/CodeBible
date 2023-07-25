# Password Expiration Policies

## Set the Password to Never Expire

```PowerShell
Update-MgUser -UserId <user ID> -PasswordPolicies DisablePasswordExpiration -PassThru
```

## Get the Current Password Policy

```PowerShell
Get-MGuser -UserId <user id or UPN> -Property UserPrincipalName, PasswordPolicies
```

## Documentation

<https://learn.microsoft.com/en-us/microsoft-365/admin/add-users/set-password-to-never-expire>