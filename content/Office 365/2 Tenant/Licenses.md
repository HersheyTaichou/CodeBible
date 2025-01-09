# Working with Licenses

Various commands and scripts for working with Licenses in Office 365 through Microsoft Graph

## Prerequisites

Before running any of these commands, you will need to connect to [Microsoft Graph](../1%20Global/Microsoft.Graph.md) with the following scopes

```PowerShell
Connect-MgGraph -Scopes "User.Read.All"
```

## Scripts

### Get All Users with Current Licenses

The following script will output a CSV that contains all of the accounts in the tenant and includes what licenses the users are assigned.

```PowerShell
$MgUsers = Get-MgUser -All
$Output =@()
$Output = foreach ($user in $MgUsers) {
    $Properties = [ordered]@{
        "DisplayName" = $User.DisplayName
        "ID" = $user.Id
        "UserPrincipalName" = $user.UserPrincipalName
        "Licenses" = (Get-MgUserLicenseDetail -UserId $user.Id).SkuPartNumber -join ";"

    }
    New-Object -TypeName PSObject -Property $Properties
}
$Output | export-csv LicensedUsers.csv
```
