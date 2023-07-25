# Find a Particular Alias

Run the following command in Exchange Online

```PowerShell
Get-EXORecipient -Filter  {EmailAddresses -like "*email*"} | FL DisplayName,EmailAddresses
```
