---
title: Generate Battery Health Reports
---

## Windows 8.1 and below

Open an elevated CMD prompt and run the following

```bat
Powercfg /energy /output C:\temp\EnergyReport.html
```

## Windows 10 and up

Open an elevated CMD or PowerShell prompt and run the following

```cmd
Powercfg /batteryreport /output C:\temp\Battery.html
powercfg /SYSTEMPOWERREPORT /Output C:\temp\sleepstudy-report.html
```
