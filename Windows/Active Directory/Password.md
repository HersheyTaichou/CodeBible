# Find Password Expiration Dates

## Get Everyone's Expiration Date

This will filter for only enabled users and users that have a password that will expire.

```PowerShell
Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed","PasswordLastSet" | Select-Object -Property "Displayname","PasswordLastSet",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}
```

## Get a Specific User's Expiration Date

Update "Username" to the username of the person we want to check.

```PowerShell
Get-ADUser -filter {SamAccountName -eq "Username"} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed","PasswordLastSet",Enabled,PasswordNeverExpires | Select-Object -Property "Displayname","PasswordLastSet",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}},Enabled,PasswordNeverExpires

```
