# Various Commands to get System Info

## BIOS Version

```bat
wmic bios get smbiosbiosversion
```

## Get Installed Driver Versions

```PowerShell
 Get-WmiObject win32_pnpsigneddriver | Select-Object DeviceName,Manufacturer,DriverVersion
```
