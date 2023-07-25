# Public Folders in Exchange Online

## Bulk Add users to Public Folders

This script can take upwards of 36 hours of continuous running to complete:

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
