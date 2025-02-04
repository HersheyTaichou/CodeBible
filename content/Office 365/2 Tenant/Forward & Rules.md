---
title: Find Mailbox Forwards
description: Find email forwards either through rules or a setting on the mailbox.
---

The following scripts will generate reports on any forward in place on a mailbox or setup via a rule in the mailbox.

## Prerequisites

These commands require the #ExchangeOnlineManagement module.

## Commands

### All Forwards

```PowerShell
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | where {$Null -ne $_.ForwardingSmtpAddress} | Export-Csv C:\Temp\Forwards.csv -NoTypeInformation
```

### Get All Rules to Forward Emails Externally

> This was added as a function to the [CodeBible module](https://github.com/HersheyTaichou/CodeBible-Module) and can be run with `Get-ForwardRules -OnlyExternal`

```PowerShell
$domains = Get-AcceptedDomain
$mailboxes = Get-ExoMailbox -ResultSize Unlimited

$RuleArray = @()

foreach ($mailbox in $mailboxes) {
    $forwardingRules = $null
    Write-Host "Checking rules for $($mailbox.displayname) - $($mailbox.primarysmtpaddress)" -foregroundColor Green
    $rules = get-inboxrule -Mailbox $mailbox.primarysmtpaddress

    $forwardingRules = $rules | Where-Object {$_.forwardto -or $_.forwardasattachmentto}

    foreach ($rule in $forwardingRules) {
        $recipients = @()
        $recipients = $rule.ForwardTo | Where-Object {$_ -match "SMTP"}
        $recipients += $rule.ForwardAsAttachmentTo | Where-Object {$_ -match "SMTP"}

        $externalRecipients = @()

        foreach ($recipient in $recipients) {
            $email = ($recipient -split "SMTP:")[1].Trim("]")
            $domain = ($email -split "@")[1]

            if ($domains.DomainName -notcontains $domain) {
                $externalRecipients += $email
            }
        }

        if ($externalRecipients) {
            $extRecString = $externalRecipients -join ", "
            Write-Host "$($rule.Name) forwards to $extRecString" -ForegroundColor Yellow

            $ruleHash = $null
            $ruleHash = [ordered]@{
                PrimarySmtpAddress = $mailbox.PrimarySmtpAddress
                DisplayName        = $mailbox.DisplayName
                RuleId             = $rule.Identity
                RuleName           = $rule.Name
                RuleDescription    = $rule.Description
                ExternalRecipients = $extRecString
            }
            $RuleArray += $ruleHash
        }
    }
}
```
