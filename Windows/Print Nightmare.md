# PrintNightmare patch tests

Check for the patches that fixed the PrintNightmare vulnerability

```PowerShell
$patches = @("KB5003711","KB5004947","KB5001403","KB5004954","KB5001402","KB5004948")
Get-HotFix -Id $patches -ErrorAction SilentlyContinue
```

Check to see if the Drivers folder has been locked down

```PowerShell
$Path = "C:\Windows\System32\spool\drivers"
(Get-Item $Path).GetAccessControl('Access') | Format-List
```
