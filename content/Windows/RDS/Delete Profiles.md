# Remove a user's profile from an RD farm

This can be used to quickly remove a user's profile from multiple members of a farm

Change the following array to contain a list of all the servers in the farm that we want to remove the profiles from

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
