# User Termination PowerShell Steps

Change FLast to match the terminated user's username and disabledOU to where you want to move the account to

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

Hide the user from any Address lists

```PowerShell
Set-ADObject -Identity $Username -replace @{msExchHideFromAddressLists=$true;}
```

Set on-prem as a remote shared mailbox

```PowerShell
Set-ADObject -Identity $Username -replace @{msExchRecipientDisplayType=-2147483642;}
Set-ADObject -Identity $Username -replace @{msExchRecipientTypeDetails=34359738368;}
Set-ADObject -Identity $Username -replace @{msExchRemoteRecipientType=100;}
```

Set the description to the disabled date

```PowerShell
Set-ADObject -Identity $Username -Description "Disabled $(get-date -Format 'yyyy/MM/dd')"
```

Generate a random 20-character string and set the user's password to it:

```PowerShell
$Password = -join ((33..126) | Get-Random -Count 20 | ForEach-Object {[char]$_})
$Password
Set-ADAccountPassword -Identity $Username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText -String $Password -Force)
```

Disable the user's AD account

```PowerShell
Disable-ADAccount -Identity $Username
```

Move the user to the disabled OU specified above

```PowerShell
Move-ADObject -Identity $Username -TargetPath $disabledOU
```
