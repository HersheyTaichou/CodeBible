# Search for Details in Exchange Online

## Prerequisites

Before running these scripts, you will need to connect to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md)

## Commands

### Find a Particular Alias

```PowerShell
Get-EXORecipient -Filter  {EmailAddresses -like "*email*"} | FL DisplayName,EmailAddresses
```
