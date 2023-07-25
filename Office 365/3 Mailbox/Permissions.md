# Grant Deleage Access

## Grant Mailbox Access

### Grant Full Access

Note: Full access does not include send-as or send-on-behalf permissions.

```PowerShell
Add-MailboxPermission -Identity <MailboxIdentity> -User <DelegateIdentity> -AccessRights FullAccess [-AutoMapping $false]
```

If `-AutoMapping` is set to false, the mailbox will not be added to Outlook automatically and will need to be added manually, if needed.

This can be useful if you need to add the mailbox as a second account in Outlook. In that case, when adding the mailbox to Outlook, specify the mailbox's email, but use the Delegate's credentials when authenticating.

### Grant Send-As Permissions

Office 365

```PowerShell
Add-RecipientPermission "Help Desk" -AccessRights SendAs -Trustee "Ayla Kol"
```

On-Prem Exchange

```PowerShell
$UsertoSendAs = Get-ADUser -Filter 'Name -like "Full Name"'
$UserSendingAs = Get-ADUser -Filter 'Name -like "Full Name"'
Add-ADPermission -Identity $UsertoSendAs.Name -User $UserSendingAs.Name -AccessRights ExtendedRight -ExtendedRights "Send As"
```

### Grant Send-on-behalf Permissions

Office 365

```PowerShell
Set-Mailbox -Identity <MailboxIdentity> -GrantSendOnBehalfTo <DelegateIdentity>
```

### Documentation

[Manage permissions for recipients in Exchange Online](https://learn.microsoft.com/en-us/exchange/recipients-in-exchange-online/manage-permissions-for-recipients)

[Add-ADPermission](https://docs.microsoft.com/en-us/powershell/module/exchange/add-adpermission)

## Grant Calendar Access
