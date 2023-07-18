# Connect to Exchange and Azure
Connect-ExchangeOnline
Connect-MgGraph  -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"
$Username = get-ExoRecipient "user@domain.com"

# Disable Exchange Activesync
Set-CASMailbox -Identity $Username.PrimarySmtpAddress -ActiveSyncEnabled $false -OWAforDevicesEnabled $false -PopEnabled $False -ImapEnabled $False -OWAEnabled $False -EWSEnabled $False -MAPIEnabled $False -OutlookMobileEnabled $false

# Give user access to mailbox
Add-MailboxPermission -Identity $Username.PrimarySmtpAddress -User "CWhelan" -AccessRights FullAccess

# Sign out all applications
Invoke-MgInvalidateUserRefreshToken -UserId $Username.PrimarySmtpAddress

# Convert mailbox to shared
Set-Mailbox -Identity $Username.PrimarySmtpAddress -Type Shared

# Remove all mobile devices on the server
Get-MobileDeviceStatistics -Mailbox $Username.PrimarySmtpAddress | Remove-MobileDevice

# Set OOO Message
$OoOMessage = "User is no longer with Company. Please contact manager@domain.com."
Set-MailboxAutoReplyConfiguration -Identity $Username.PrimarySmtpAddress -AutoReplyState Enabled -InternalMessage $OoOMessage -ExternalMessage $OoOMessage
