# Restore soft-deleted mailbox data into another mailbox

Get the ExchangeGuid from the source and target mailboxes

```PowerShell
$SourceMailbox = (Get-Mailbox -SoftDeletedMailbox user@domain.com).ExchangeGuid

$TargetMailbox = (Get-Mailbox -Identity User@domain.com).ExchangeGuid
```

Run the restore

```PowerShell
New-MailboxRestoreRequest -SourceMailbox $SourceMailbox -TargetMailbox $TargetMailbox -AllowLegacyDNMismatch
```
