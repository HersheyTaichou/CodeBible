# Azure and Exchange Online User Termination Commands

## Prerequisites

Before running these commands, you will need to connect to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md) and [Microsoft Graph](../1%20Global/Microsoft.Graph.md) with the following scopes

```PowerShell
Connect-MgGraph -Scopes "User.ReadWrite.All"
```

## Process

### Get the user

```PowerShell
$Username = (get-ExoRecipient "user@domain.com").PrimarySmtpAddress
```

### Disable Exchange Activesync

```PowerShell
Set-CASMailbox -Identity $Username -ActiveSyncEnabled $false -OWAforDevicesEnabled $false -PopEnabled $False -ImapEnabled $False -OWAEnabled $False -EWSEnabled $False -MAPIEnabled $False -OutlookMobileEnabled $false
```

### Give another user access to the mailbox

```PowerShell
Add-MailboxPermission -Identity $Username -User "manager@domain.com" -AccessRights FullAccess
```

### Sign out all applications and devices

```PowerShell
Revoke-MgUserSignInSession -UserId $Username
```

### Convert mailbox to shared

```PowerShell
Set-Mailbox -Identity $Username -Type Shared
```

### Remove all mobile devices on the server

```PowerShell
Get-MobileDeviceStatistics -Mailbox $Username | Remove-MobileDevice
```

### Set OOO Message

```PowerShell
$OoOMessage = "User is no longer with Company. Please contact manager@domain.com."
Set-MailboxAutoReplyConfiguration -Identity $Username -AutoReplyState Enabled -InternalMessage $OoOMessage -ExternalMessage $OoOMessage
```

### Cancel reoccurring Appointments

The mailbox must still exist in the tenant for this to work

```PowerShell
Remove-CalendarEvents -Identity chris@contoso.com -CancelOrganizedMeetings
```
