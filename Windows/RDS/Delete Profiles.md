# Remove a user's profile from an RD farm

Change to a list of all the servers in the farm

```PowerShell
$ComputerName = @("Azure-RDS01","Azure-RDS02","Azure-RDS03","Azure-RDS04","Azure-RDS05","Azure-RDS06")
```

Get all the user's profiles on the farm

```PowerShell
$UserProfiles = Get-WmiObject -Class Win32_UserProfile -ComputerName $ComputerName | Where-Object {$_.LocalPath.split('\')[-1] -eq 'username'}
```

Delete the profiles from all the servers

```PowerShell
$UserProfiles | ForEach-Object {$_.Delete()}
```
