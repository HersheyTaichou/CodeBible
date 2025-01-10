---
title: Manage Emails in Bulk
description: Bulk Import, Export, or Delete Emails
---

Below you will find various commands useful for managing email in bulk.

## Prerequisites

Before running any of these commands, you will need to connect with the [[ExchangeOnlineManagement|Exchange Online PowerShell Module]]

## Commands

### Import Data

```PowerShell
New-MailboxImportRequest -Mailbox User@domain.com -FilePath \\server\share\import.pst -TargetRootFolder /
```

### Export Data

This cmdlet is available only in on-premises Exchange.

```PowerShell
New-MailboxExportRequest -Mailbox user@domain.com -ContentFilter {(Received -lt '02/01/2019')} -FilePath \\server\share\export.pst
```

### Bulk Delete

The following script will delete all emails during the specific time range but will ignore calendar invites, contacts, and other data in the mailbox. We have to use a Do-Until loop, because -DeleteContent will only remove 20 emails at once

```PowerShell
$mbx = get-mailbox user@domain.com
Do {
    $result = Search-Mailbox -Identity $mbx.Identity -SearchQuery '(kind:email) AND (sent:01/01/2000..02/01/2019)' -DeleteContent -Force -WarningAction Silentlycontinue -DoNotIncludeArchive
    write-host $result.resultitemscount -ForegroundColor Green
} Until ($result.resultitemscount -eq 0)
```

## More Information

[New-MailboxImportRequest](https://learn.microsoft.com/en-us/powershell/module/exchange/new-mailboximportrequest)

[New-MailboxExportRequest](https://learn.microsoft.com/en-us/powershell/module/exchange/new-mailboxexportrequest)

[Search-Mailbox](https://learn.microsoft.com/en-us/powershell/module/exchange/search-mailbox)
