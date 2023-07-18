# Change to a list of all the servers in the farm
$ComputerName = @("Azure-RDS01","Azure-RDS02","Azure-RDS03","Azure-RDS04","Azure-RDS05","Azure-RDS06")
# Get all the user's profiles on the farm
$UserProfiles = Get-WmiObject -Class Win32_UserProfile -ComputerName $ComputerName | Where-Object {$_.LocalPath.split('\')[-1] -eq 'username'}
# Delete the profiles from all the servers 
$UserProfiles | ForEach-Object {$_.Delete()}
