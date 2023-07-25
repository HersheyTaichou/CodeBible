# Make Teams Calendars visible to Outlook clients

```PowerShell
Set-UnifiedGroup -Identity team@domain.com -HiddenFromExchangeClientsEnabled:$False
```

It should now be searchable as a shared calendar
