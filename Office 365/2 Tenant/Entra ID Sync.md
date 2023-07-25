# Entra ID Sync

This application is formally known as Azure AD Sync

## Import the module

Normally, you should not need to import it, it should import automatically when you run commands.

```PowerShell
Import-Module "C:\Program Files\Microsoft Azure AD Sync\Bin\ADSync\ADSync.psd1"
```

## Run the sync

Use PolicyType Delta to only sync changes since the last run:

```PowerShell
Start-ADSyncSyncCycle -PolicyType Delta
```

Use PolicyType Initial to sync everything

```PowerShell
Start-ADSyncSyncCycle -PolicyType Initial
```

## Get Sync Status

```PowerShell
Get-ADSyncConnectorRunStatus
```
