---
title: Migrate a mailbox to another database server
---

This command can be useful when a mailbox is behaving oddly. It will migrate the mailbox to another server on Microsoft's end and appears to repair it at the same time, which can fix odd issues.

## Prerequisites

Before running these commands, you will need to connect with the [[ExchangeOnlineManagement|Exchange Online PowerShell Module]]

## Commands

### Start a Migration

The migration can take a while and the user will need to close and re-open Outlook after it is done.

```PowerShell
New-MoveRequest User@domain.com
```

### Monitor a Migration

```PowerShell
Get-MoveRequestStatistics User@domain.com
```

These commands can take a while and the user will need to close and re-open Outlook after they complete
