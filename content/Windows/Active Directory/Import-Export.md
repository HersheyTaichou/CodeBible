# Bulk Import or Export Details from AD

## Import

Script: <https://gallery.technet.microsoft.com/scriptcenter/Update-Active-Directory-cd5c5513>

Field names for the CSV file: <https://www.manageengine.com/products/ad-manager/help/csv-import-management/active-directory-ldap-attributes.html>

## Export

```PowerShell
Get-ADUser -Filter * -SearchBase (Get-ADDomain).DistinguishedName -Properties * | Export-Csv "c:\temp\ADUsers.csv" -NoTypeInformation
```

The parameter "-Filter" is used to specify the query string, "-SearchBase" to specify an Active Directory path to search under and the "-Properties" to specify the user's properties you want to export.

## Documentation

<https://social.technet.microsoft.com/Forums/windowsserver/en-US/f7ae07a0-f2cd-42a8-b5b3-97b582ca8cad/export-users-to-csv?forum=winserverDS>
