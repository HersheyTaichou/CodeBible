# Get All Calendar/Contact/Root folder Permissions

```PowerShell
$AllUsers = Get-Mailbox -ResultSize:Unlimited
$allUserDetails = @()
$Counter=0
ForEach ($user in $allusers) {
    $Counter++
    Write-Progress -Id 0 -Activity 'Processing Users' -CurrentOperation $user -PercentComplete (($Counter / $allusers.count) * 100)
    $UPNCalendar = $User.UserPrincipalName + ":\Calendar"
    $calDetails = Get-EXOMailboxFolderPermission -Identity $UPNCalendar
    $CounterA=0
    forEach ($entry in $calDetails) {
        $CounterA++
        Write-Progress -Id 1 -ParentId 0 -Activity 'Processing Calendars' -CurrentOperation $entry.user -PercentComplete (($CounterA / $calDetails.count) * 100)
        $accessRights = ""
        forEach ($permission in $entry.accessRights) {
            $accessRights += $permission + "; "
        }
        $Properties =  [ordered]@{'Identity'=$entry.Identity;'FolderName'=$entry.FolderName;'User'=$entry.User;'AccesRights'=$accessRights;'SharingPermissionFlags'=$entry.SharingPermissionFlags}
        $allUserDetails += New-Object -TypeName PSObject -Property $Properties
    }
    $UPNContacts = $User.UserPrincipalName + ":\Contacts"
    $conDetails = Get-EXOMailboxFolderPermission -Identity $UPNContacts
    $CounterA=0
    forEach ($entry in $conDetails) {
        $CounterA++
        Write-Progress -Id 1 -ParentId 0 -Activity 'Processing Contacts' -CurrentOperation $entry.user -PercentComplete (($CounterA / $conDetails.count) * 100)
        $accessRights = ""
        forEach ($permission in $entry.accessRights) {
            $accessRights += $permission + "; "
        }
        $Properties =  [ordered]@{'Identity'=$entry.Identity;'FolderName'=$entry.FolderName;'User'=$entry.User;'AccesRights'=$accessRights;'SharingPermissionFlags'=$entry.SharingPermissionFlags}
        $allUserDetails += New-Object -TypeName PSObject -Property $Properties
    }
    $RootFolder = $User.UserPrincipalName + ":\"
    $fullDetails = Get-EXOMailboxFolderPermission -Identity $RootFolder
    $CounterA=0
    forEach ($entry in $fullDetails) {
        $CounterA++
        Write-Progress -Id 1 -ParentId 0 -Activity 'Processing root folders' -CurrentOperation $entry.user -PercentComplete (($CounterA / $fullDetails.count) * 100)
        $accessRights = ""
        forEach ($permission in $entry.accessRights) {
            $accessRights += $permission + "; "
        }
        $Properties =  [ordered]@{'Identity'=$entry.Identity;'FolderName'=$entry.FolderName;'User'=$entry.User;'AccesRights'=$accessRights;'SharingPermissionFlags'=$entry.SharingPermissionFlags}
        $allUserDetails += New-Object -TypeName PSObject -Property $Properties
    }
}

$allUserDetails | export-csv C:\Temp\All-Calendar-Contacts-Details.csv -NoTypeInformation

```
