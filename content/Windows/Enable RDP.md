# Enable Remote Desktop through PowerShell

Run the following command in an elevated PowerShell session. It may require a reboot to apply but can be run using remote monitoring tools.

```Powershell
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
```
