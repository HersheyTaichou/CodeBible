---
title: Link an AD User to an Office 365 Mailbox
description: Manually link or repair a link between an AD user and an Office 365 mailbox
---
This is often needed in the following scenarios

- The Office 365 account was previously connected to a different AD account
- There was a duplicate account in Office 365

## Prerequisites

- You will need administrative access to a domain controller
- You will need to connect to the [[Microsoft.Graph|Microsoft Graph PowerShell Module]] with the following scopes:
  
  ```PowerShell
  Connect-MgGraph -Scopes "User.ReadWrite.All"
  ```

## Process

Here are the steps to resolve

1. Move the user  out of a synced OU
2. Run an Azure AD Sync / Entra ID Sync
3. Log in to Microsoft Graph
4. Get a list of deleted users

   ```PowerShell
   $Uri = "https://graph.microsoft.com/V1.0/directory/deletedItems/microsoft.graph.user"
   [array]$DeletedUsers = Invoke-MgGraphRequest -Uri $Uri -Method Get
   $DeletedUsers.value | Select-Object displayName,mail,id
   ```

5. Note the ID of the deleted user, then run the following command
   - Be VERY careful to ensure you remove the correct account!
   - This will purge the mailbox contents!

   ```PowerShell
   Remove-MgDirectoryDeletedItem -DirectoryObjectId "ID GOES HERE"
   ```

6. Get the AD user's ImmutableID
   1. Log into an AD server
   2. Run the following commands

      ```PowerShell
      $guid = (get-Aduser <username>).ObjectGuid
      $immutableID = [System.Convert]::ToBase64String($guid.tobytearray())
      $immutableID
      ```

   3. Note the Immutable ID
7. Update the Immutable ID with Microsoft Graph
   1. Log into MS Graph
   2. Run the following command, substitute $immutableID for the value we obtained in AD

   ```PowerShell
   Update-MgUser -UserID User@domain.com -OnPremisesImmutableId $immutableID
   ```

8. Move the account back into the synced OU and run a sync

The accounts should be linked in Office 365 now
