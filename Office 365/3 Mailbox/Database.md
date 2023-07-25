# Migrate a mailbox to another database server

This command can be useful when a mailbox is behaving oddly. It will migrate the mailbox to another server on Microsoft's end and appears to do a repair at the same time, which can fix odd issues.

Run this command to start the migration

```PowerShell
New-MoveRequest User@domain.com
```

Run this command to monitor the migration

```PowerShell
Get-MoveRequestStatistics User@domain.com
```

These commands can take a while and the user will need to close and re-open Outlook after they complete
