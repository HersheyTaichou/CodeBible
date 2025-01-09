# Canon Printers

## How to Install

I have found that the Canon printer drivers will only work if you are signed into a local account with Administrative permissions.

### Domain-Joined install

1. Log in with a Domain account that has local Administrator permissions
1. Open "Edit local users and groups"
1. Create a new local account
   - I find it best to name it after the domain account, than use the same password, but defer to your company's policies
1. Add the new account to the Administrators group on the machine
1. Log out and log in with the local account
   - To log in with a local account, append the machine name with a backslash ( Workstation\ ) or do a period with a backslash ( .\ ) then the account name
1. Run the driver install as normal
