# Dealing with the 260 Character Limit

Tasks to find files over the limit and a fix to extend the limit.

## Finding files over the limit

This command will list all files in the specified path that are over the 260-character limit.

```PowerShell
Get-ChildItem -literalpath C:\Path\To\Folder -Recurse |  Where-Object {$_.FullName.Length -gt 260}
```

## Extending the limit

This will allow Windows to go past the 260-character limit

### Using Powershell

```PowerShell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
-Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
```

### Using Group Policy

Open the group policy editor and update the following key

> Computer Configuration > Administrative Templates > System > Filesystem > Enable Win32 long paths

## Documentation

[Maximum Path Length Limitation](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation)
