# Generate a Folder Permissions Report

Contents of a separate file called "shares.csv"

| Name | Path |
| ----------- | ----------- |
| Department2 | F:\Department2 |
| Departments | F:\Departments |
| RDSProfiles | F:\RDSProfiles |
| Redirected Folders | F:\Redirected Folders |

The following script will load the above file, loop through its contents, then output a file for each share with the permissions for that share, named after the share.

```PowerShell
$Shares = Import-Csv -Path "Shares.csv"
$CounterA = 0
ForEach ($Share in $Shares) {
    $CounterA++
    Write-Progress -Activity 'Processing shares' -CurrentOperation $Share -PercentComplete (($CounterA / $Shares.count) * 100) -Status (($CounterA / $Shares.count) * 100)
    $CurFolderName = $Share.Name
    $CurFolderPath = $Share.Path
    $FolderPath = @(Get-Item -Path $CurFolderPath)
    $FolderPath += Get-ChildItem -Directory -Path "$CurFolderPath" -Recurse -Force -EA SilentlyContinue
    $Output = @()
    $CounterB = 0
    $Output = ForEach ($Folder in $FolderPath) {
        $CounterB++
        Write-Progress -Id 1 -Activity 'Processing Folders' -CurrentOperation $Folder -Status (($CounterB / $FolderPath.count) * 100) -PercentComplete (($CounterB / $FolderPath.count) * 100)
        $ACLPath = $Folder.FullName
        $Acl = Get-Acl -Path "$ACLPath"
        $CounterC = 0
        ForEach ($Access in $Acl.Access) {
            $CounterC++
            Write-Progress -Id 2 -Activity 'Processing Access' -CurrentOperation $FAccessolder -Status (($CounterC / $Acl.Access.count) * 100) -PercentComplete (($CounterC / $Acl.Access.count) * 100)
            if ($Access.IsInherited -eq $False) {
                $Properties = [ordered]@{'Folder Name'=$Folder.FullName;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights}
                New-Object -TypeName PSObject -Property $Properties
            }
        }
    }
    $Output | Export-CSV "$CurFolderName.csv" -NoTypeInformation
}
```
