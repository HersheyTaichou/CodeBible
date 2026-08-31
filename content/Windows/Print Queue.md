# Manually Clear the Print Queue

1. Open an admin CMD or PowerShell prompt
2. Type `net stop spooler` then press “Enter“.
3. Type `del %systemroot%\System32\spool\printers\* /Q` then press “Enter“.
4. Type `net start spooler` then press “Enter“.
5. The print queue on your Windows PC should now be cleared.

Source: <https://www.technipages.com/windows-clear-print-queue>
