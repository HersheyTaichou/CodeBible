# Change Username to the user's
$Username = Get-ADObject -Filter {SamAccountName -eq "FLast"}
# Set to the disabled user OU. You can get the format of this string in the OU attribute editor
$disabledOU = "OU=Disabled Accounts,DC=company,DC=local"

# Get a list of the user's groups, then remove them from all groups
$groups = Get-ADPrincipalGroupMembership -Identity $Username | Where-Object -Property "Name" -ne "Domain Users"
$groups | Select-Object @{Name=$Username.Name;Expression={$_.Name}}
ForEach($group in $groups) {Remove-ADPrincipalGroupMembership -Identity $Username -MemberOf $group.Sid -Confirm:$False}

# Clear manager field
Set-ADUser -Identity $Username -Manager $Null

# Hide from Address lists
Set-ADObject -Identity $Username -replace @{msExchHideFromAddressLists=$true;}
# Set on-prem as remote shared mailbox
Set-ADObject -Identity $Username -replace @{msExchRecipientDisplayType=-2147483642;}
Set-ADObject -Identity $Username -replace @{msExchRecipientTypeDetails=34359738368;}
Set-ADObject -Identity $Username -replace @{msExchRemoteRecipientType=100;}

# Set the description to the disable date:
Set-ADObject -Identity $Username -Description "Disabled $(get-date -Format 'yyyy/MM/dd')"

# Reset the password
Set-ADAccountPassword -Identity $Username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText 'Example Password!!!!1' -Force)

# Disable the AD account
Disable-ADAccount -Identity $Username

# Move to disabled OU
Move-ADObject -Identity $Username -TargetPath $disabledOU
