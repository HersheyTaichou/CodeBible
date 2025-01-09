---
title: Searches in Exchange Online
---
How to search for specific details in Exchange Online
## Prerequisites

Before running these scripts, you will need to connect with the [[ExchangeOnlineManagement|Exchange Online PowerShell Module]]

## Commands

### Find a Particular Alias

```PowerShell
Get-EXORecipient -Filter  {EmailAddresses -like "*email*"} | FL DisplayName,EmailAddresses
```
