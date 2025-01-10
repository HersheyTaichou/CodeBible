---
title: Restore a Soft-Deleted Mailbox
---

In the case when an account was deleted and the mailbox was orphaned, you can create a new account, then link the old mailbox to the new account.

## Prerequisites

Before running these commands, you will need administrative access to the Exchange on-prem server or you will need to connect to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md)

## Commands

Get the ExchangeGuid from the source and target mailboxes

```PowerShell
$SourceMailbox = (Get-Mailbox -SoftDeletedMailbox user@domain.com).ExchangeGuid

$TargetMailbox = (Get-Mailbox -Identity User@domain.com).ExchangeGuid
```

Run the restore

```PowerShell
New-MailboxRestoreRequest -SourceMailbox $SourceMailbox -TargetMailbox $TargetMailbox -AllowLegacyDNMismatch
```
