# Gather Specific User Details

## Have not logged in within the last 30 days

```PowerShell
Get-ADUser -Filter {Enabled -eq $TRUE} -SearchBase (Get-ADDomain).DistinguishedName -Properties Name, SamAccountName, LastLogonDate, UserPrincipalName, Mail | Where {($_.LastLogonDate -lt (Get-Date).AddDays(-30)) -and ($_.LastLogonDate -ne $NULL)} | Sort | Select Name, SamAccountName, LastLogonDate, UserPrincipalName, Mail
```

## Have logged in within the last 30 days

```PowerShell
Get-ADUser -Filter {Enabled -eq $TRUE} -SearchBase (Get-ADDomain).DistinguishedName -Properties Name,SamAccountName,LastLogonDate,UserPrincipalName,Mail | Where {($_.LastLogonDate -gt (Get-Date).AddDays(-30)) -and ($_.LastLogonDate -ne $NULL)} | Sort | Select Name,SamAccountName,LastLogonDate,UserPrincipalName,Mail | Export-Csv "c:\temp\active-users.csv" -NoTypeInformation
```
