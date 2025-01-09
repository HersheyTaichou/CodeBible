---
title: Mailbox Folder Permissions Report
---

The below script will gather all the recipient accounts, then gather anyone that has access to the Calendar, Contacts, or root folder

## Prerequisites

Before running this script, you will need to connect with the [[ExchangeOnlineManagement|Exchange Online PowerShell Module]]

## Script

Copy and paste the whole block into PowerShell, or a ps1 file, then run it.

```PowerShell
$AllUsers = Get-Recipient -ResultSize:Unlimited
$UserFolders = @(":\",":\Calendar",":\Contacts")
$allUserDetails = @()
$Counter=0
ForEach ($user in $allusers) {
    $Counter++
    Write-Progress -Id 0 -Activity "Processing User" -PercentComplete (($Counter / $allusers.count) * 100)
    foreach ($Folder in $UserFolders) {
        $UPNFolder = ($user.ExchangeGuid).ToString() + $Folder
        $FolderPerms = Get-MailboxFolderPermission -Identity $UPNFolder
        if ($null -ne $FolderPerms) {
            $CounterA=0
            $allUserDetails = foreach ($entry in $FolderPerms) {
                $CounterA++
                Write-Progress -Id 1 -ParentId 0 -Activity "Processing Folder" -PercentComplete (($CounterA / $FolderPerms.count) * 100)
                $Properties =  [ordered]@{
                    'Identity'=$entry.Identity;
                    'FolderName'=$entry.FolderName;
                    'User'=$entry.User;
                    'AccesRights'=$entry.accessRights -join ";";
                    'SharingPermissionFlags'=$entry.SharingPermissionFlags
                }
                New-Object -TypeName PSObject -Property $Properties
            }
        }
    }
}

$allUserDetails | export-csv C:\Temp\All-Calendar-Contacts-Details.csv -NoTypeInformation
```
