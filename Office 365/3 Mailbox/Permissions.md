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

## Grant Folder Access

The following commands work for any folder in the mailbox, all you have to do is substitute Calendar for Contacts or any other folder name.

### Get Folder permissions

```PowerShell
Get-EXOMailboxFolderPermission -Identity user@domain.com:\Calendar -User user@domain.org
```

### Add Folder Permissions

```PowerShell
Add-MailboxFolderPermission -Identity user@domain.com:\Calendar -User user@domain.org -AccessRights Author
```

### Update Folder Permissions

```PowerShell
Set-MailboxFolderPermission user@domain.com:\Calendar -User user@domain.com -AccessRights Author
```

The following individual permissions are available:

- **CreateItems**   The user can create items in the specified folder.
- **CreateSubfolders**   The user can create subfolders in the specified folder.
- **DeleteAllItems**   The user can delete all items in the specified folder.
- **DeleteOwnedItems**   The user can only delete items that they created from the specified folder.
- **EditAllItems**   The user can edit all items in the specified folder.
- **EditOwnedItems**   The user can only edit items that they created in the specified folder.
- **FolderContact**   The user is the contact for the specified public folder.
- **FolderOwner**   The user is the owner of the specified folder. The user can view the folder, move the folder, and create subfolders. The user can't read items, edit items, delete items, or create items.
- **FolderVisible**   The user can view the specified folder, but can't read or edit items within the specified public folder.
- **ReadItems**   The user can read items within the specified folder.

The available roles, along with the permissions that they assign, are described in the following list:

- **Author**   CreateItems, DeleteOwnedItems, EditOwnedItems, FolderVisible, ReadItems
- **Contributor**   CreateItems, FolderVisible
- **Editor**   CreateItems, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderVisible, ReadItems
- **None**   FolderVisible
- **NonEditingAuthor**   CreateItems, FolderVisible, ReadItems
- **Owner**   CreateItems, CreateSubfolders, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderContact, FolderOwner, FolderVisible, ReadItems
- **PublishingEditor**   CreateItems, CreateSubfolders, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderVisible, ReadItems
- **PublishingAuthor**   CreateItems, CreateSubfolders, DeleteOwnedItems, EditOwnedItems, FolderVisible, ReadItems
- **Reviewer**   FolderVisible, ReadItems
The following roles apply specifically to calendar folders:
- **AvailabilityOnly**   View only availability data
- **LimitedDetails**   View availability data with subject and location

### Add user as Delegate

To change delegate permissions (Such as adding CanViewPrivateItems) you have to `Remove-MailboxFolderPermission`, then add a new entry. Delegate access requires the Editor AccessRights

```PowerShell
Add-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User laura@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems
```

## Documentation

[Manage permissions for recipients in Exchange Online](https://learn.microsoft.com/en-us/exchange/recipients-in-exchange-online/manage-permissions-for-recipients)

[Add-ADPermission](https://docs.microsoft.com/en-us/powershell/module/exchange/add-adpermission)

<https://technet.microsoft.com/en-us/library/ff522363(v=exchg.160).aspx>
