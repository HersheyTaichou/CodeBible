# Search Event Logs in Powershell

Search for events in PowerShell, then store the results in an array, for easy export or additional filtering

```PowerShell
$Results = Get-EventLog -LogName System
$Results
```

[Get-EventLog](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1)
