---
title: Groups in Exchange Online
---

The following are scripts for working with groups in Microsoft Online.

For a table like the following, use the (One File) scripts

| Group name          | Members                                |
| ------------------- | -------------------------------------- |
| <group1@domain.com> | <user1@domain.com>; <user2@domain.com> |
| <group2@domain.com> | <user1@domain.com>; <user3@domain.com> |

For one file per group, with just the members of that group, use the (Per Group) scripts

| Members            |
| ------------------ |
| <user1@domain.com> |
| <user1@domain.com> |

## Prerequisites

Before running these scripts, you will need to connect to the [[ExchangeOnlineManagement|Exchange Online PowerShell Module]]

## Scripts

### Bulk Add members to DL

Use the following commands to add all the listed emails in a CSV to one distribution list. The CSV should have only one column with a list of email addresses.

```PowerShell
$Members = Import-CSV Members.csv
Add-DistributionGroupMember -Identity group@domain.com -Member $Members
```

### Get All Distribution groups with Members (One File)

```PowerShell
$GroupList = Get-DistributionGroup
$GroupsWMembers = @()

$GroupsWMembers = ForEach ($Group in $GroupList) {
    $memberList = ''
    $GroupMembers = Get-DistributionGroupMember "$group"
    ForEach($Member in $GroupMembers) {
        If($memberList) {
            $memberList=$memberList + "; " + $Member.PrimarySmtpAddress
        } Else {
            $memberList=$Member.PrimarySmtpAddress
        }
    }
    $Properties = [ordered]@{'GroupName'=$group;'Members'=$memberList}
    New-Object -TypeName PSObject -Property $Properties
}
$GroupsWMembers | Export-CSV "DL-Members.csv" -NoTypeInformation
```

### Get All Shared Mailboxes with Members (One File)

```PowerShell
$GroupList = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited
$GroupsWMembers = @()

$GroupsWMembers = ForEach ($Group in $GroupList) {
    $memberList = ''
    $GroupMembers = Get-MailboxPermission -Identity "$group" | ?{($_.IsInherited -eq $False) -and -not ($_.User -match “NT AUTHORITY”)}
    ForEach($Member in $GroupMembers) {
        If($memberList) {
            $memberList=$memberList + "; " + $Member.User
        } Else {
            $memberList=$Member.User
        }
    }
    New-Object -TypeName PSObject -Property @{
        GroupName = $group
        Members = $memberList
    }
}
$GroupsWMembers | Export-CSV "Shared-Members.csv" -NoTypeInformation
```

### Get All Microsoft 365 Groups with Members (One File)

```PowerShell
$GroupList = Get-UnifiedGroup
$GroupsWMembers = @()

$GroupsWMembers = ForEach ($Group in $GroupList) {
    $memberList = ''
    $GroupMembers = Get-UnifiedGroupLinks -LinkType Member -Identity "$group"
    ForEach($Member in $GroupMembers) {
        If($memberList) {
            $memberList=$memberList + "; " + $Member.PrimarySmtpAddress
        } Else {
            $memberList=$Member.PrimarySmtpAddress
        }
    }
    New-Object -TypeName PSObject -Property @{
        GroupName = $group.DisplayName
        Members = $memberList
    }
}
$GroupsWMembers | Export-CSV "O365-Members.csv" -NoTypeInformation
```

### Get All Distribution Groups with Members (Per Group)

```PowerShell
$GroupList = Get-DistributionGroup

Foreach($Group In $GroupList) {
    $name = $Group.DisplayName
    Get-DistributionGroupMember $group.PrimarySmtpAddress | Export-csv "$name.csv"
}
```

### Get All Shared Mailboxes with Members (Per Group)

```PowerShell
$GroupList = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited
Foreach($Group In $GroupList) {
    $name = $Group.Name
    Get-MailboxPermission -Identity $group.PrimarySmtpAddress | ?{($_.IsInherited -eq $False) -and -not ($_.User -match “NT AUTHORITY”)} | Export-csv "C:\Temp\Client\$name.csv"
}
```

### Get All Microsoft 365 Groups with Members (Per Group)

```PowerShell
$GroupList = Get-UnifiedGroup
Foreach($Group In $GroupList) {
    $name = $Group.Name
    Get-UnifiedGroupLinks -LinkType Member -Identity $group.PrimarySmtpAddress | Export-csv "C:\Temp\Client\$name.csv"
}
```

### Exchange Distribution Group Membership Logs

1. sign in to the Exchange Admin Center.
2. go to compliance management > auditing.
3. click run the admin audit log report.
4. Filter by date and click search
