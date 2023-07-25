# Enable full O365 Mailbox Auditing

Retrieve all of the logs for a group of mailboxes

```PowerShell
Search-MailboxAuditLog -Mailboxes User1@Domain.Com, User2@Domain.Com, User3@Domain.Com -LogonTypes Admin,Delegate -StartDate MM/DD/YYYY -EndDate MM/DD/YYYY -ResultSize 99999
```
