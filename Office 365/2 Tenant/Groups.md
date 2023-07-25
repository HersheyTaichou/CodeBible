# Groups in Exchange Online

## Bulk Add members to DL

Use the following commands to add all the listed emails in a CSV to one distribution list

```PowerShell
$Members = Import-CSV Members.csv
Add-DistributionGroupMember -Identity group@domain.com -Member $Member
```

## Get all the DLs with their members

```PowerShell
$GroupList = Get-DistributionGroup
$GroupsWMembers = @()

ForEach ($Group in $GroupList) {
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
    $GroupsWMembers += New-Object -TypeName PSObject -Property $Properties}
}
$GroupsWMembers | Export-CSV "DL-Members.csv" -NoTypeInformation
```

## Get All the Shared Mailboxes with Members

```PowerShell
$GroupList = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited
$GroupsWMembers = @()

ForEach ($Group in $GroupList) {
    $memberList = ''
    $GroupMembers = Get-MailboxPermission -Identity "$group" | ?{($_.IsInherited -eq $False) -and -not ($_.User -match “NT AUTHORITY”)}
    ForEach($Member in $GroupMembers) {
        If($memberList) {
            $memberList=$memberList + "; " + $Member.User
        } Else {
            $memberList=$Member.User
        }
    }
    $GroupsWMembers += New-Object -TypeName PSObject -Property @{
        GroupName = $group
        Members = $memberList
    }
}
$GroupsWMembers | Export-CSV "Shared-Members.csv" -NoTypeInformation
```

## Get All the Office 365 Groups with Members

```PowerShell
$GroupList = Get-UnifiedGroup
$GroupsWMembers = @()

ForEach ($Group in $GroupList) {
    $memberList = ''
    $GroupMembers = Get-UnifiedGroupLinks -LinkType Member -Identity "$group"
    ForEach($Member in $GroupMembers) {
        If($memberList) {
            $memberList=$memberList + "; " + $Member.PrimarySmtpAddress
        } Else {
            $memberList=$Member.PrimarySmtpAddress
        }
    }
    $GroupsWMembers += New-Object -TypeName PSObject -Property @{
        GroupName = $group.DisplayName
        Members = $memberList
    }
}
$GroupsWMembers | Export-CSV "O365-Members.csv" -NoTypeInformation
```

## Exchange Distribution Group Membership Logs

1. sign in to the Exchange Admin Center.
2. go to compliance management > auditing.
3. click run the admin audit log report.
4. Filter by date and click search
