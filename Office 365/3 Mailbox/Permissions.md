# Adjusting Access to a User's Mailbox

The following commands will allow you to give another user access to a mailbox or a folder in that mailbox, for delegate or monitoring purposes.

For the folder permission commands, they work for any folder in the mailbox, all you have to do is substitute Calendar for Contacts or another folder name.

## Prerequisites

Before running these commands, you will need to connect to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md)

## Commands

### Grant Full Access to a Mailbox

Note: Full access does not include send-as or send-on-behalf permissions.

```PowerShell
Add-MailboxPermission -Identity <MailboxIdentity> -User <DelegateIdentity> -AccessRights FullAccess [-AutoMapping $false]
```

If `-AutoMapping` is set to false, the mailbox will not be added to Outlook automatically and will need to be added manually, if needed.

This can be useful if you need to add the mailbox as a second account in Outlook. In that case, when adding the mailbox to Outlook, specify the mailbox's email, but use the Delegate's credentials when authenticating.

### Grant Send-As Permissions to a Mailbox

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

### Grant Send-on-behalf Permissions to a Mailbox

```PowerShell
Set-Mailbox -Identity <MailboxIdentity> -GrantSendOnBehalfTo <DelegateIdentity>
```

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

- CreateItems[^CreateItems]
- CreateSubfolders[^CreateSubfolders]
- DeleteAllItems[^DeleteAllItems]
- DeleteOwnedItems[^DeleteOwnedItems]
- EditAllItems[^EditAllItems]
- EditOwnedItems[^EditOwnedItems]
- FolderContact[^FolderContact]
- FolderOwner[^FolderOwner]
- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

The available roles, along with the permissions that they assign, are described in the following list:

<details>
<summary>Author</summary>

- CreateItems[^CreateItems]
- DeleteOwnedItems[^DeleteOwnedItems]
- EditOwnedItems[^EditOwnedItems]
- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

</details>

<details>
<summary>Contributor</summary>

- CreateItems[^CreateItems]
- FolderVisible[^FolderVisible]

</details>

<details>
<summary>Editor</summary>

- CreateItems[^CreateItems]
- DeleteAllItems[^DeleteAllItems]
- DeleteOwnedItems[^DeleteOwnedItems]
- EditAllItems[^EditAllItems]
- EditOwnedItems[^EditOwnedItems]
- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

</details>

<details>
<summary>None</summary>

- FolderVisible[^FolderVisible]

</details>

<details>
<summary>NonEditingAuthor</summary>

- CreateItems[^CreateItems]
- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

</details>

<details>
<summary>Owner</summary>

- CreateItems[^CreateItems]
- CreateSubfolders[^CreateSubfolders]
- DeleteAllItems[^DeleteAllItems]
- DeleteOwnedItems[^DeleteOwnedItems]
- EditAllItems[^EditAllItems]
- EditOwnedItems[^EditOwnedItems]
- FolderContact[^FolderContact]
- FolderOwner[^FolderOwner]
- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

</details>

<details>
<summary>PublishingEditor</summary>

- CreateItems[^CreateItems]
- CreateSubfolders[^CreateSubfolders]
- DeleteAllItems[^DeleteAllItems]
- DeleteOwnedItems[^DeleteOwnedItems]
- EditAllItems[^EditAllItems]
- EditOwnedItems[^EditOwnedItems]
- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

</details>

<details>
<summary>PublishingAuthor</summary>

- CreateItems[^CreateItems]
- CreateSubfolders[^CreateSubfolders]
- DeleteOwnedItems[^DeleteOwnedItems]
- EditOwnedItems[^EditOwnedItems]
- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

</details>

<details>
<summary>Reviewer</summary>

- FolderVisible[^FolderVisible]
- ReadItems[^ReadItems]

</details>

The following roles apply specifically to calendar folders:

- **AvailabilityOnly**   View only availability data
- **LimitedDetails**   View availability data with subject and location

[^CreateItems]: The user can create items in the specified folder.
[^CreateSubfolders]: The user can create subfolders in the specified folder.
[^DeleteAllItems]: The user can delete all items in the specified folder.
[^DeleteOwnedItems]: The user can only delete items that they created from the specified folder.
[^EditAllItems]: The user can edit all items in the specified folder.
[^EditOwnedItems]: The user can only edit items that they created in the specified folder.
[^FolderContact]: The user is the contact for the specified public folder.
[^FolderOwner]: The user is the owner of the specified folder. The user can view the folder, move the folder, and create subfolders. The user can't read items, edit items, delete items, or create items.
[^FolderVisible]: The user can view the specified folder, but can't read or edit items within the specified public folder.
[^ReadItems]: The user can read items within the specified folder.

### Add user as Delegate

To change delegate permissions (Such as adding CanViewPrivateItems) you have to `Remove-MailboxFolderPermission`, then add a new entry. Delegate access requires the Editor AccessRights

```PowerShell
Add-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User laura@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems
```

## More Information

[Manage permissions for recipients in Exchange Online](https://learn.microsoft.com/en-us/exchange/recipients-in-exchange-online/manage-permissions-for-recipients)

[Add-ADPermission](https://docs.microsoft.com/en-us/powershell/module/exchange/add-adpermission)

<https://technet.microsoft.com/en-us/library/ff522363(v=exchg.160).aspx>
