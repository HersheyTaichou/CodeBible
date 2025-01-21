---
title: Disable Events from Email
---

> These settings define whether Outlook or Outlook on the web (formerly known as Outlook Web App) automatically discovers events from email messages and adds them to the user's calendar.  
> &mdash; From [Set-EventsFromEmailConfiguration](https://learn.microsoft.com/en-us/powershell/module/exchange/set-eventsfromemailconfiguration)

## Prerequisites

These commands require the #ExchangeOnlineManagement module.

## Commands

### Reset Permissions for the entire company

```PowerShell
Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Set-EventsFromEmailConfiguration -ResetSettings
```

### Disable processing for the entire company

```PowerShell
Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Set-EventsFromEmailConfiguration -FlightReservationProcessingLevel Disabled -LodgingReservationProcessingLevel Disabled -ParcelDeliveryProcessingLevel Disabled -RentalCarReservationProcessingLevel Disabled
```

## More Information

[Events from Email in Office 365 and how to disable them](http://www.michev.info/Blog/Post/174/Events-from-Email-in-Office-365-and-how-to-disable-them)

[Set-EventsFromEmailConfiguration](https://learn.microsoft.com/en-us/powershell/module/exchange/set-eventsfromemailconfiguration)
