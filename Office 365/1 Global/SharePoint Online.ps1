# Install the module
Install-Module -Name Microsoft.Online.SharePoint.PowerShell

# Update the module
Update-Module -Name Microsoft.Online.SharePoint.PowerShell

# Import the module (should not usually be needed)
Import-Module -Name Microsoft.Online.SharePoint.PowerShell

# Connect to SPO
Connect-SPOService -Url https://contoso-admin.sharepoint.com

# Connect to SPO, for when  you get an error telling you to use Modern Authentication
Connect-SPOService -Credential $creds -Url https://tenant-admin.sharepoint.com -ModernAuth $true -AuthenticationUrl https://login.microsoftonline.com/organizations

# Source: https://learn.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online
