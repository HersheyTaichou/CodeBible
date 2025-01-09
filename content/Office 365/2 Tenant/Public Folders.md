---
title: Public Folders in Exchange Online
---
The following are scripts that can be useful when working with public folders in Exchange Online

## Prerequisites

Before running these scripts, you will need to connect to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md)

## Scripts

### Bulk Add users to Public Folders

This script can take a significant amount of time to complete, as it goes through each folder in Exchange and changes the permissions for them.

```PowerShell
# Get a list of all the folders to change
$PublicFolders = Get-PublicFolder -Identity "\FolderName" -Recurse

# Reverse the order, to update from newest to oldest folders
[array]::Reverse($PublicFolders)

# Run the following commands for each folder in the array
forEach ($Folder in $PublicFolders) {
    # Use this command to remove someone from all the folders
    Remove-PublicFolderClientPermission -Identity $Folder.Identity -Confirm:$false -User user@domain.com | Select Identity,User,AccessRights

    # Use this command to add someone to all the folders
    Add-PublicFolderClientPermission -Identity $Folder.Identity -User user@domain.com -AccessRights PublishingEditor | Select Identity,User,AccessRights
}
```
