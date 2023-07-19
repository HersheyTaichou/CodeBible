# Upload a photo to a user with SPO

You can use the following commands to update a user's photo in Entra ID and Exchange Online. This is good for changing several users' photos with a single script.

## Set the user's photo

```PowerShell
Set-UserPhoto -Identity "user@domain.com" -PictureData ([System.IO.File]::ReadAllBytes("C:\temp\$user.jpg")) -Preview -Confirm:$false
```

## Save the new photo

```PowerShell
Set-UserPhoto -Identity "user@domain.com" -Save -Confirm:$false
```

## Confirm it was applied

```PowerShell
Get-UserPhoto -Identity "user@domain.com"
```
