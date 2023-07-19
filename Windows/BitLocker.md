# Setup BitLocker with PowerShell

First, add a recovery key protector. The key will be printed to the console, make sure to record it.

```PowerShell
Add-BitLockerKeyProtector -MountPoint "C:" -RecoveryPasswordProtector
```

Next, enable and set it to use the TPM

```PowerShell
Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -SkipHardwareTest -TpmProtector
```

Get the available key protectors (TPM, Recovery Password, etc)

```PowerShell
(Get-BitLockerVolume -MountPoint C).KeyProtector
```

Remove a key protector

```PowerShell
(Get-BitLockerVolume -MountPoint C).KeyProtector[0].KeyProtectorId | Remove-BitLockerKeyProtector -MountPoint C
```

## Documentation

[Add-BitLockerKeyProtector](https://learn.microsoft.com/en-us/powershell/module/bitlocker/add-bitlockerkeyprotector)  
[Enable-BitLocker](https://learn.microsoft.com/en-us/powershell/module/bitlocker/enable-bitlocker)  
[Get-BitLockerVolume](https://learn.microsoft.com/en-us/powershell/module/bitlocker/get-bitlockervolume)  
[Remove-BitLockerKeyProtector](https://learn.microsoft.com/en-us/powershell/module/bitlocker/remove-bitlockerkeyprotector)
