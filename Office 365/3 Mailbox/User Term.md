# Azure and Exchange Online User Termination Commands

## Connect to Exchange and Azure

At the very least, you will need to connect to Exchange Online. To sign the user out of all devices, you will need to log in to Microsoft Graph

## Get the user and save their object as a variable

```PowerShell
$Username = (get-ExoRecipient "user@domain.com").PrimarySmtpAddress
```

## Disable Exchange Activesync

```PowerShell
Set-CASMailbox -Identity $Username -ActiveSyncEnabled $false -OWAforDevicesEnabled $false -PopEnabled $False -ImapEnabled $False -OWAEnabled $False -EWSEnabled $False -MAPIEnabled $False -OutlookMobileEnabled $false
```

## Give another user access to the mailbox

```PowerShell
Add-MailboxPermission -Identity $Username -User "CWhelan" -AccessRights FullAccess
```

## Sign out all applications and devices

This command requires the "User.ReadWrite.All" scope when connecting to Microsoft Graph

```PowerShell
Revoke-MgUserSignInSession -UserId $Username
```

## Convert mailbox to shared

```PowerShell
Set-Mailbox -Identity $Username -Type Shared
```

## Remove all mobile devices on the server

```PowerShell
Get-MobileDeviceStatistics -Mailbox $Username | Remove-MobileDevice
```

## Set OOO Message

```PowerShell
$OoOMessage = "User is no longer with Company. Please contact manager@domain.com."
Set-MailboxAutoReplyConfiguration -Identity $Username -AutoReplyState Enabled -InternalMessage $OoOMessage -ExternalMessage $OoOMessage
```

## Cancel reoccurring Appointments

The mailbox must still exist in the tenant for this to work

```PowerShell
Remove-CalendarEvents -Identity chris@contoso.com -CancelOrganizedMeetings
```