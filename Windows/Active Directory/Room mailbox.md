# Update On-Prem Accounts to Cloud Rooms

This would be used when a company has a hybrid Exchange, and you want a cloud mailbox that was converted to a room to reflect accurately in the on-prem Exchange

In the below script, update `FLast` to the person's username, then run the rest of the commands as-is.

```PowerShell
$Username = Get-ADObject -Filter {SamAccountName -eq "FLast"}
Set-ADObject -Identity $Username -replace @{msExchRecipientDisplayType=-2147481850;}
Set-ADObject -Identity $Username -replace @{msExchRecipientTypeDetails=8589934592;}
Set-ADObject -Identity $Username -replace @{msExchRemoteRecipientType=36;}
```
