# Set on prem as remote room mailbox
Set-ADObject -Identity $Username -replace @{msExchRecipientDisplayType=-2147481850;}
Set-ADObject -Identity $Username -replace @{msExchRecipientTypeDetails=8589934592;}
Set-ADObject -Identity $Username -replace @{msExchRemoteRecipientType=36;}
