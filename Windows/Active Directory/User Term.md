# User Termination PowerShell Steps

Change FLast to match the terminated user's username and the Disabled OU to when you want to move the account to

```PowerShell
$Username = Get-ADObject -Filter {SamAccountName -eq "FLast"}
$disabledOU = "OU=Disabled Accounts,DC=company,DC=local"
```

Get a list of the user's groups, list them, then remove them from all groups

```PowerShell
$groups = Get-ADPrincipalGroupMembership -Identity $Username | Where-Object -Property "Name" -ne "Domain Users"
$groups | Select-Object @{Name=$Username.Name;Expression={$_.Name}}
ForEach($group in $groups) {Remove-ADPrincipalGroupMembership -Identity $Username -MemberOf $group.Sid -Confirm:$False}
```

Clear the user's manager field

```PowerShell
Set-ADUser -Identity $Username -Manager $Null
```

Hide the user from any from Address lists

```PowerShell
Set-ADObject -Identity $Username -replace @{msExchHideFromAddressLists=$true;}
```

Set on-prem as a remote shared mailbox

```PowerShell
Set-ADObject -Identity $Username -replace @{msExchRecipientDisplayType=-2147483642;}
Set-ADObject -Identity $Username -replace @{msExchRecipientTypeDetails=34359738368;}
Set-ADObject -Identity $Username -replace @{msExchRemoteRecipientType=100;}
```

Set the description to the disable date

```PowerShell
Set-ADObject -Identity $Username -Description "Disabled $(get-date -Format 'yyyy/MM/dd')"
```

Reset the user's password

```PowerShell
Set-ADAccountPassword -Identity $Username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText 'Example Password!!!!1' -Force)
```

Disable the user's AD account

```PowerShell
Disable-ADAccount -Identity $Username
```

Move to the user to the disabled OU specificed above

```PowerShell
Move-ADObject -Identity $Username -TargetPath $disabledOU
```
