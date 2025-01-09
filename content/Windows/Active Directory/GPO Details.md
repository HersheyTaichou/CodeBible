# Get GPO Details

## All GPOs for the Domain

Run this from one of the DCs

```PowerShell
Get-GPOReport -All -Domain (Get-ADDomain).DNSRoot -Server (Get-ADDomain).PDCEmulator -ReportType HTML -Path "C:\Temp\GPOReportsAll.html"
```

## Details for the User

### For the Logged-in user

Run as-is in PowerShell and it will output a file named after the user

```PowerShell
gpresult  /H "C:\Temp\$env:UserName.html" /SCOPE USER
```

### For a Different User

Update "domain\username" to match the user you want the report for

```PowerShell
gpresult  /H "C:\Temp\gpresult.html" /SCOPE USER /USER "domain\username"
```

## Details for the Computer

```PowerShell
gpresult  /H "C:\Temp\$env:UserName.html" /SCOPE COMPUTER
```
