# Run Repairs on Windows

## Check for OS issues

```PowerShell
DISM /Online  /Cleanup-Image /AnalyzeComponentStore ;; Repair-WindowsImage -Online -ScanHealth ;; Repair-Volume -DriveLetter C
```

## Repair OS issues

### PowerShell on Windows 10 and up

```PowerShell
DISM /online /Cleanup-Image /StartComponentCleanup  ;; Repair-WindowsImage -Online -RestoreHealth -Verbose ;; sfc /scannow ;; Repair-Volume -DriveLetter C -Scan -Verbose ;; findstr /c:"[SR]" $ENV:windir\Logs\CBS\CBS.log >"C:\temp\sfcdetails_$(Get-date -Format 'yyyy-MM-dd_HHmm').txt"
```

### CMD on Windows 8.1 and below

```bat
DISM /online /Cleanup-Image /StartComponentCleanup && dism /Online /Cleanup-Image /RestoreHealth && sfc /scannow && chkdsk C: &&  findstr /c:"[SR]" %windir%\Logs\CBS\CBS.log >"C:\temp\sfcdetails1.txt"
```

### More Extensive Windows 10 Repair

After running `sfc /scannow` in cmd, you get the following error message:

```text
Windows Resource Protection found corrupt files but was unable to fix some of them.
```

If you review the log files, you see entries like the following:

```text
2015-12-12 11:58:26, Info CSI 00003d48 [SR] Cannot repair member file [l:10]"opencl.dll" of microsoft-windows-RemoteFX-clientVM-RemoteFXWDDMDriver-WOW64-C, version 10.0.10586.0, arch Host= amd64 Guest= x86, nonSxS, pkt {l:8 b:31bf3856ad364e35} in the store, hash mismatch
2015-12-12 11:58:27, Info CSI 00003d52 [SR] Cannot repair member file [l:10]"opencl.dll" of microsoft-windows-RemoteFX-clientVM-RemoteFXWDDMDriver-WOW64-C, version 10.0.10586.0, arch Host= amd64 Guest= x86, nonSxS, pkt {l:8 b:31bf3856ad364e35} in the store, hash mismatch
2015-12-12 11:58:27, Info CSI 00003d53 [SR] This component was referenced by [l:125]"Microsoft-Windows-RemoteFX-VM-Setup-Package~31bf3856ad364e35~amd64~~10.0.10586.0.RemoteFX clientVM and UMTS files and regkeys"
2015-12-12 11:58:27, Info CSI 00003d56 [SR] Could not reproject corrupted file [l:23 ml:24]"\??\C:\WINDOWS\SysWOW64"[l:10]"opencl.dll"; source file in store is also corrupted
```

Running `Repair-WindowsImage -Online -RestoreHealth -Verbose` fails with an error like the following:

```text
Error: 0x800f081f The source files could not be found. Use the "Source" option to specify the location of the files that are required to restore the feature.
```

Here are the steps to fix it:

1. Mount an ISO image for the version of Windows on the user's machine.
2. Create a temporary directory to mount the Windows Image File (WIM).  
`mkdir C:\WIM`
3. Mount the WIM file.

    ```PowerShell
    Dism /Mount-Wim /WimFile:D:\sources\install.wim /index:1 /MountDir:C:\WIM /ReadOnly
    ```

4. Run Dism with the following parameters.

    ```PowerShell
    Dism /Online /Cleanup-Image /RestoreHealth /Source:C:\WIM\Windows /LimitAccess
    ```

5. When done, unmount the image and delete the folder

    ```PowerShell
    Dism /Unmount-Wim /MountDir:C:\WIM /Discard 
    rmdir C:\WIM
    ```

6. It's mandatory to restart your computer, or SFC and DISM will still show errors.

## Repair Domain Trust

First, save the domain admin credentials in a variable:

```PowerShell
$cred = Get-Credential
```

These run a quick fix but may fail if the computer has been off the domain for too long, or some other issue.

```PowerShell
Reset-ComputerMachinePassword -Credential $cred -Verbose
Test-ComputerSecureChannel -Repair -Verbose -Credential $cred
```

[Reset-ComputerMachinePassword Documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/reset-computermachinepassword)

[Test-ComputerSecureChannel Documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-computersecurechannel)

### Leave and re-join the domain

These commands will require an active connection to a domain controller (On-site or VPN) and they recommend a reboot between, but it is not required.  
These commands also invalidate locally cached domain credentials, so a connection to a DC will be required for the user to sign back in.

The easiest way to do that remotely is:

1. Run these commands
2. Reboot
3. Sign in with a local account
4. Connect to the VPN
5. Switch users and have the user sign-in

```PowerShell
Remove-Computer -WorkgroupName TEMP -UnjoinDomainCredential $cred
Add-Computer -Credential $cred -DomainName corp.domain.com
```

Run this command to confirm the domain trust is fixed:

```PowerShell
Test-ComputerSecureChannel -Verbose
```

## Reinstall all Windows Apps

Run the following command in an admin PowerShell window

```PowerShell
Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
```

Wait until the app download and installation process completes — ignore any red text that appears — and restart Windows.
