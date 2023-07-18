# Enter domain admin credentials
$cred = Get-Credential

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/reset-computermachinepassword
Reset-ComputerMachinePassword -Credential $cred -Verbose
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-computersecurechannel
Test-ComputerSecureChannel -Repair -Verbose -Credential $cred

<# 
Remove the computer from the domain and re-join it. 
These commands will require an active connection to a domain controller (On-site or VPN) and they recommend a reboot between, but it is not required.
These commands also invalidate local cached domain credentials, so a connection to a DC will be required for the user to sign back in.
The easiest way to do that remotely is:
1. Run these commands
2. Reboot
3. Sign in with a local account
4. Connect to the VPN
5. Switch users and have the user sign-in
#>
Remove-Computer -WorkgroupName TEMP -UnjoinDomainCredential $cred
Add-Computer -Credential $cred -DomainName corp.chartis.com

#  this command confirms the domain trust is 
Test-ComputerSecureChannel -Verbose