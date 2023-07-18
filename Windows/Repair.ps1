# Check for issues
DISM /Online  /Cleanup-Image /AnalyzeComponentStore ;; Repair-WindowsImage -Online -ScanHealth ;; Repair-Volume -DriveLetter C

# Repair issues
## PowerShell:
DISM /online /Cleanup-Image /StartComponentCleanup  ;; Repair-WindowsImage -Online -RestoreHealth -Verbose ;; sfc /scannow ;; Repair-Volume -DriveLetter C -Scan -Verbose ;; findstr /c:"[SR]" $ENV:windir\Logs\CBS\CBS.log >"C:\temp\sfcdetails_$(Get-date -Format 'yyyy-MM-dd_HHmm').txt"

## CMD:
DISM /online /Cleanup-Image /StartComponentCleanup && dism /Online /Cleanup-Image /RestoreHealth && sfc /scannow && chkdsk C: &&  findstr /c:"[SR]" %windir%\Logs\CBS\CBS.log >"C:\temp\sfcdetails1.txt"
