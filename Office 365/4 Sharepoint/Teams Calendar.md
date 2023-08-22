# Microsoft 365 Groups (Teams) Calendars

Commands to make changes or work with the calendars connected to a Microsoft 365 Group.

## Prerequisites

Before running these commands, you will need to connect to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md)

## Commands

### Add a Group calendar to the GAL

```PowerShell
Set-UnifiedGroup -Identity team@domain.com -HiddenFromExchangeClientsEnabled:$False
```

It should now be searchable as a shared calendar

## More Information

[Set-UnifiedGroup](https://learn.microsoft.com/en-us/powershell/module/exchange/set-unifiedgroup?view=exchange-ps)
