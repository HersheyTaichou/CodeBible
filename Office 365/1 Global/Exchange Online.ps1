# Install the module
Install-Module -Name ExchangeOnlineManagement 

# Update the module
Update-Module -Name ExchangeOnlineManagement

# Import the module (should not usually be needed)
Import-Module -Name ExchangeOnlineManagement

# Connect using the client's global admin
## This will open a browser window for login. Use the global admin for the tenant you want to manage
Connect-ExchangeOnline

# Connect using our partner access
## This will open a browser window for login. Use your partner credentials to authenticate
Connect-ExchangeOnline -DelegatedOrganization domain.onmicrosoft.com