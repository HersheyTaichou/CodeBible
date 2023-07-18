# Upload a photo to a user with SPO

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
