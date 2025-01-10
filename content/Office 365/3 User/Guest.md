---
title: Manage Entra ID Guest Accounts
description: Tips on managing guest accounts in Entra ID
---

This article goes over how to gather details on guest users in Entra ID

## Prerequisites

Before running these commands, you will need to connect to the [[Microsoft.Graph|Microsoft Graph PowerShell Module]] with the following scopes:

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

### Guest User Cleanup

> [!module] A script has been added to the Code Bible Module to find and remove any guest users have have not signed in for a specified number of days. The module can be found [here](https://github.com/HersheyTaichou/CodeBible-Module)

```PowerShell
$Guests = Get-MgBetaUser -all -Select SignInActivity | Where-Object {$_.UserType -eq "Guest"}
$Age = Read-Host -Prompt "Enter a negative number of days, any guest accounts that have not signed in for that number of days will be disabled:"
$RemoveGuests = $Guests | Where-Object {$_.CreatedDateTime -le (Get-Date).AddDays($Age) -and $_.SignInActivity.LastSuccessfulSignInDateTime -le (Get-Date).AddDays($Age)}
$RemoveGuests | ForEach-Object {Update-MgUser -UserId $_.Id -AccountEnabled $false}
```

## More Information

[Source](https://stackoverflow.com/collectives/azure/articles/75885876/how-to-retrieve-the-last-sign-in-date-time-for-all-users-in-azure-ad-using-micro)
