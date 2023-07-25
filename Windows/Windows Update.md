# Windows Updates

## Install Updates Via PowerShell

Powershell has to be at least version 5, run this command to check the version

```PowerShell
$PSVersionTable.PSVersion
```

### Install the Windows Update module

```PowerShell
Install-Module PSWindowsUpdate
```

### Get Updates for all Microsoft Products

```PowerShell
Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d
```

### Show Available Updates

```PowerShell
Get-WindowsUpdate -Verbose
```

### Install All Updates

```PowerShell
Install-WindowsUpdate -Verbose -AcceptAll
```

### View Update History

```PowerShell
Get-Wuhistory
```

### Uninstall an Update

```PowerShell
Remove-WindowsUpdate -KBArticleID KB4489873
```

### Hide Updates

```PowerShell
$HideList = "KB4489873", "KB4489883"
Hide-WindowsUpdate -KBArticleID $HideList –Hide
```

### Documentation

<http://woshub.com/pswindowsupdate-module/>

## Fix Failing Windows Updates

1. Open an admin terminal and stop the following services

    ```bat
    net stop bits
    net stop wuauserv
    net stop appidsvc
    net stop cryptsvc
    ```

2. Delete the auto-update registry key, and rename the Windows Update cache folders

    ```bat
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\" /V RebootRequired /F
    Ren %systemroot%\SoftwareDistribution SoftwareDistribution.bak
    Ren %systemroot%\system32\catroot2 catroot2.bak
    ```

3. Restart the services

    ```bat
    net start bits
    net start wuauserv
    net start appidsvc
    net start cryptsvc 
    ```

4. Restart the computer and run Windows Update again

## Utility to Temporarily Hide Updates

<http://download.microsoft.com/download/f/2/2/f22d5fdb-59cd-4275-8c95-1be17bf70b21/wushowhide.diagcab>
