# Work with AD Groups

## Get all groups a member is part of

```PowerShell
Get-ADPrincipalGroupMembership -Identity "Username"
```

## Export a Report of All the Groups with their Members

This will export one text file with each group name and the members under it

```PowerShell
$Groups = Get-ADGroup -Properties * -Filter * -SearchBase (Get-ADDomain).DistinguishedName
Foreach($Group In $Groups) {
    "-------------" | Out-File -Append -filepath 'Groups.txt'
    $Group.Name | Out-File -Append -filepath 'Groups.txt'
    "-------------" | Out-File -Append -filepath 'Groups.txt'
    Get-ADGroupMembers -Identity $Group | Select Name,objectClass | Out-File -Append -filepath 'Groups.txt'
    "`n" | Out-File -Append -filepath 'Groups.txt'
}
```

This will export one CSV for each group, with the members of that group

```PowerShell
$Groups = Get-ADGroup -Properties * -Filter * -SearchBase (Get-ADDomain).DistinguishedName
Foreach($Group In $Groups) {
    $name = $Group.Name
    Get-ADGroupMembers -Identity $Group | Export-csv C:\Temp\Client\$name.csv
}
```
