# Bulk Change AD user's Expiry date

Adjust the search base to match the OU the users are saved in. Adjust the date to match when the user's account should expire.

**NOTE**: This is different than the password expiration. This updates the AD User Properties > Account tab in AD, the Account Expiration settings at the bottom of the tab.

```PowerShell
Get-ADUser -Filter * -SearchBase "OU=Vendors,OU=Company,DC=Domain,DC=local" | Set-ADAccountExpiration -DateTime "06/01/2022"
```
