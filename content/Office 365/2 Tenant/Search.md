---
title: Searches in Exchange Online
---

How to search for specific details in Exchange Online

## Prerequisites

These commands require the #ExchangeOnlineManagement module.

## Commands

### Find a Particular Alias

```PowerShell
Get-EXORecipient -Filter  {EmailAddresses -like "*email*"} | FL DisplayName,EmailAddresses
```
