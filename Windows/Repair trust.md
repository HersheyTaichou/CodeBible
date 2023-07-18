# Repair a Computer's Domain

First, save the domain admin credentials

```PowerShell
$cred = Get-Credential
```

## Repair the domain trust

These run a quick fix, but may fail if the computer has been off the domain for too long, or some other issue.

```PowerShell
Reset-ComputerMachinePassword -Credential $cred -Verbose
Test-ComputerSecureChannel -Repair -Verbose -Credential $cred
```

[Reset-ComputerMachinePassword Documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/reset-computermachinepassword)

[Test-ComputerSecureChannel Documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-computersecurechannel)

## Leave and re-join the domain

These commands will require an active connection to a domain controller (On-site or VPN) and they recommend a reboot between, but it is not required.  
These commands also invalidate local cached domain credentials, so a connection to a DC will be required for the user to sign back in.

The easiest way to do that remotely is:

1. Run these commands
2. Reboot
3. Sign in with a local account
4. Connect to the VPN
5. Switch users and have the user sign-in

```PowerShell
Remove-Computer -WorkgroupName TEMP -UnjoinDomainCredential $cred
Add-Computer -Credential $cred -DomainName corp.chartis.com
```

Run this command confirms the domain trust is fixed

```PowerShell
Test-ComputerSecureChannel -Verbose
```
