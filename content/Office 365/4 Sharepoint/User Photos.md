# Office 365 User Photos

You can use the following commands to update a user's photo in Entra ID and Exchange Online. This is good for changing several users' photos with a single script.

## Prerequisites

Before running these commands, you will need to connect to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md)

## Commands

### Set the user's photo

```PowerShell
Set-UserPhoto -Identity "user@domain.com" -PictureData ([System.IO.File]::ReadAllBytes("C:\temp\$user.jpg")) -Preview -Confirm:$false
```

### Save the new photo

```PowerShell
Set-UserPhoto -Identity "user@domain.com" -Save -Confirm:$false
```

### Confirm it was applied

This will return the photo as an encoded string of characters. This is mostly useful for comparing to the previous value, to confirm it changed, or if the user did not have a photo before, that one was applied.

```PowerShell
Get-UserPhoto -Identity "user@domain.com"
```

## More Information

[Set-UserPhoto](https://learn.microsoft.com/en-us/powershell/module/exchange/set-userphoto?view=exchange-ps)
