# Install Updates Via PowerShell

Powershell has to be at least version 5, run this command to check the version

```PowerShell
$PSVersionTable.PSVersion
```

## Install the Windows Update module

```PowerShell
Install-Module PSWindowsUpdate
```

## Get Updates for all Microsoft Products

```PowerShell
Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d
```

## Show Available Updates

```PowerShell
Get-WindowsUpdate -Verbose
```

## Install All Updates

```PowerShell
Install-WindowsUpdate -Verbose -AcceptAll
```

## View Update History

```PowerShell
Get-Wuhistory
```

## Uninstall an Update

```PowerShell
Remove-WindowsUpdate -KBArticleID KB4489873
```

## Hide Updates

```PowerShell
$HideList = "KB4489873", "KB4489883"
Hide-WindowsUpdate -KBArticleID $HideList –Hide
```

## Documentation

<http://woshub.com/pswindowsupdate-module/>
