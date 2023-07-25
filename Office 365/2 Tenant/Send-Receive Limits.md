# Adjust the Max Send/Receive Limit for Exchange Online

Get the current default limits:

```PowerShell
Get-MailboxPlan | fl name,maxsendsize,maxreceivesize,isdefault
```

Change the default limits:  
From the above command, find the one set as default, and copy the name into the below command:

```PowerShell
Set-MailboxPlan <Plan Name> -MaxSendSize 150MB -MaxReceiveSize 150MB
```

Note: 150MB is the current limit

Change all plans:

```PowerShell
(Get-MailboxPlan).name  | forEach{Set-MailboxPlan $_ -MaxSendSize 150MB -MaxReceiveSize 150MB}
```

Get the limit for a specific mailbox:

```PowerShell
Get-Mailbox "user@domain.com" | fl mailboxplan,maxsendsize,maxreceivesize
```

Change the limit for a specific mailbox:

```PowerShell
Set-Mailbox "user@domain.com" -MaxReceiveSize 150MB -MaxSendSize 150MB
```

Change the limit for all mailboxes:

```PowerShell
Get-Mailbox -Resultsize Unlimited | Set-Mailbox -MaxReceiveSize 150MB -MaxSendSize 150MB
```

From <https://practical365.com/exchange-server/configuring-max-email-message-size-limits-for-office-365/>

## Get send/receive limits and current mailbox size for all users

```PowerShell
$AllUsers = Get-Mailbox -ResultSize unlimited
$UserDetails = @()
$Counter = 0

ForEach($user in $allusers) {
    $Counter++
    Write-Progress -Activity 'Processing details' -CurrentOperation $user -PercentComplete (($counter / $allusers.count) * 100)
    $UserPrincipalName = $User.UserPrincipalName
    $Properties = [ordered]@{
        Name = $User.Name
        UserPrincipalName = $User.UserPrincipalName
        IssueWarningQuota = $User.IssueWarningQuota
        ProhibitSendQuota = $User.ProhibitSendQuota
        ProhibitSendReceiveQuota = $User.ProhibitSendReceiveQuota
        ArchiveWarningQuota = $User.ArchiveWarningQuota
        ArchiveQuota = $User.ArchiveQuota
        TotalItemSize = Get-MailboxStatistics -Identity "$UserPrincipalName" | Select TotalItemSize
    }
    $UserDetails += New-Object -TypeName PSObject -Property $Properties
}

$UserDetails | Export-CSV "Client.csv"
```
