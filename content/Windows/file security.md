# Backup and Restore File/Folder Security Permissions

## Backup Permissions

To store a copy of the current permissions we run Get-Acl, to get the permissions for a folder, then store it in a variable.

```PowerShell
$Rights = Get-Acl -Path "C:\Path\To\Folder"
```

You can now run `$Rights` in the PowerShell window to see the current permissions.

## Add to the existing permissions

```PowerShell
$username = "FLast"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($username,"FullControl","ContainerInherit, ObjectInherit","None","Allow")
$rights.SetAccessRule($AccessRule)
Set-Acl -Path "C:\Path\To\Folder" -AclObject $rights
```

Going through the script by line:

1. Define who we are permitting to access the folder
2. Define the permissions we are setting. Here is each variable in the command:
    - The name of a user account or group we are assigning the permissions to.
    - One of the [FileSystemRights](https://learn.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.filesystemrights?view=net-7.0) values that define the type of operation associated with the access rule.
    - One of the [InheritanceFlags](https://learn.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.inheritanceflags?view=net-7.0) values that defines how access masks are propagated to child objects.
    - One of the [PropagationFlags](https://learn.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.propagationflags?view=net-7.0) values that defines how Access Control Entries (ACEs) are propagated to child objects.
    - If we are allowing or denying the specified permissions.
3. Add the above access rule to the permissions we will apply
4. Apply the new permissions to the folder

## Documentation

[FileSystemAccessRule Constructors](https://learn.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.filesystemaccessrule.-ctor)
