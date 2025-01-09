# Various Commands to get System Info

## BIOS Details

### Windows BIOS

#### Version number

```bat
wmic bios get smbiosbiosversion
```

#### Check if the system is running BIOS or UEFI

```PowerShell
if (Test-Path $env:windir\Panther\setupact.log) {(Select-String 'Detected boot environment' -Path "$env:windir\Panther\setupact.log"  -AllMatches).line -replace '.*:\s+'} else {if (Test-Path HKLM:\System\CurrentControlSet\control\SecureBoot\State) {"UEFI"} else {"BIOS"}}
```

## Serial Number

### Windows Serial Number

```bat
Wmic bios get serialnumber
```

### Linux Serial Number

```bash
/usr/sbin/dmidecode | grep -e 'Manufacturer' -e 'Product Name' -e 'Serial Number' | head -n 3
```

### ESX Host Serial Number

```bash
esxcfg-info | grep "Serial N"
```

## Get Installed Driver Versions

### Windows Drivers

```PowerShell
 Get-WmiObject win32_pnpsigneddriver | Select-Object DeviceName,Manufacturer,DriverVersion
```

## OS Version info

### Windows Version

```bat
Winver
```

### Linux Distribution and Version

```bash
lsb_release -d
```
