# Bulk Import, Export or Delete Emails

## Import Data

```PowerShell
New-MailboxImportRequest -Mailbox User@domain.com -FilePath \\server\share\import.pst -TargetRootFolder /
```

## Export Data

```PowerShell
New-MailboxExportRequest -Mailbox user@domain.com -ContentFilter {(Received -lt '02/01/2019')} -FilePath \\server\share\export.pst -whatif
```

## Bulk Delete

The following script will delete all emails during the specific time range but will ignore calendar invites, contacts and other data in the mailbox. We have to use a Do..Until loop, because -DeleteContent will only remove 20 emails at once

```PowerShell
$mbx = get-mailbox user@domain.com
Do {
    $result = Search-Mailbox -Identity $mbx.Identity -SearchQuery '(kind:email) AND (sent:01/01/2000..02/01/2019)' -DeleteContent -Force -WarningAction Silentlycontinue -DoNotIncludeArchive
    write-host $result.resultitemscount -ForegroundColor Green
} Until ($result.resultitemscount -eq 0)
```

## Documentation

[New-MailboxImportRequest](https://learn.microsoft.com/en-us/powershell/module/exchange/new-mailboximportrequest)

[New-MailboxExportRequest](https://learn.microsoft.com/en-us/powershell/module/exchange/new-mailboxexportrequest)

[Search-Mailbox](https://learn.microsoft.com/en-us/powershell/module/exchange/search-mailbox)