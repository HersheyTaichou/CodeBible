# Disable Events from Email

This command will disable them for the whole company

```PowerShell
Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Set-MailboxCalendarConfiguration -EventsFromEmailEnabled $false -CreateEventsFromEmailAsPrivate $true 

```

## Documentation

<http://www.michev.info/Blog/Post/174/Events-from-Email-in-Office-365-and-how-to-disable-them>