# GAL Membership List

Use this to get a csv with all the emails in Exchange online, including if they are in the GAL or not.

```PowerShell
$FullGAL = Get-Mailbox -ResultSize Unlimited | Select-Object DisplayName,UserPrincipalName,HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-MailContact -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-MailUser -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-DistributionGroup -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-UnifiedGroup -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL | Export-Csv C:\temp\Full-GAL.csv
```
