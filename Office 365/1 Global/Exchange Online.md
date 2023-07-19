# Exchange Online

The ExchangeOnlineManagement module is used to connect to Exchange Online and run commands against objects in Exchange (Users, Groups, etc)

## Install the module

```PowerShell
Install-Module -Name ExchangeOnlineManagement
```

## Update the module

```PowerShell
Update-Module -Name ExchangeOnlineManagement
```

## Import the module

Normally, you should not need to import it, it should import automatically when you run commands.

```PowerShell
Import-Module -Name ExchangeOnlineManagement
```

## Connect to Exchange Online

### Connect using the client's global admin

This will open a browser window for login. Use the global admin for the tenant you want to manage

```PowerShell
Connect-ExchangeOnline
```

### Connect using our partner access

This will open a browser window for login. Use your partner credentials to authenticate

```PowerShell
Connect-ExchangeOnline -DelegatedOrganization domain.onmicrosoft.com
```
