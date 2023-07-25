# Working with Licenses

## Get All Licensed Users

```PowerShell
Connect-Graph -Scopes User.Read.All, Organization.Read.All
Get-MgUser -Filter "assignedLicenses/`$count eq 0 and userType eq 'Member'" -ConsistencyLevel eventual -CountVariable unlicensedUserCount -All | Export-Csv "c:\temp\licensed-users.csv" -NoTypeInformation
```
