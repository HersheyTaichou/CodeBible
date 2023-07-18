$FullGAL = Get-Mailbox -ResultSize Unlimited | Select-Object DisplayName,UserPrincipalName,HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-MailContact -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-MailUser -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-DistributionGroup -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL += Get-UnifiedGroup -ResultSize Unlimited | Select-Object DisplayName,@{Name="UserPrincipalName";Expression={$_.PrimarySmtpAddress}},HiddenFromAddressListsEnabled,RecipientTypeDetails
$FullGAL | Export-Csv C:\temp\chartis\Full-GAL.csv