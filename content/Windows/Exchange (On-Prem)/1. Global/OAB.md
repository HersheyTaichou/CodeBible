# Working with Offline Address Book

This article covers steps when troubleshooting issues with the OAB in On-Prem Exchange

## Prerequisites

You will need an account that has administrative access to the Exchange server

## Commands

### How to check the OAB update schedule

Run the following command in the Exchange console, replacing \<Server name\> with the name of the server

```PowerShell
[xml]$diag=Get-ExchangeDiagnosticInfo -Server <ServerName> -Process MSExchangeMailboxAssistants -Component VariantConfiguration -Argument "Config,Component=TimeBasedAssistants"; $diag.Diagnostics.Components.VariantConfiguration.Configuration.TimeBasedAssistants.OABGeneratorAssistant
```

It should give you a table like the following

```text
Classification                            : CustomerExpectation
MaxConcurrency                            : 1
Enabled                                   : True
EnabledDuringBlackout                     : False
MailboxNotInterestingLogInterval          : 1.00:00:00
SpreadLoad                                : False
SlaMonitoringEnabled                      : True
CompletionMonitoringEnabled               : False
ActiveDatabaseProcessingMonitoringEnabled : True
SlaUrgentThreshold                        : 0.1
SlaNonUrgentThreshold                     : 0.5
WorkCycle                                 : 08:00:00
GroupMailboxADGroupProcessingEnabled      : False
SpreadLoadPaddingPercent                  : 10
```

The `WorkCycle` entry in the table indicates how often the OAB is updated

### How to get the last OAB update time

This command will give you all of the OABs, which one is default, and when it was last updated

```PowerShell
Get-OfflineAddressBook | select Name,IsDefault,WhenChanged
```

### Check the Last Update on a PC

Open the registry and browse to the following key

```text
HKCU\Software\Microsoft\Exchange\Exchange Provider\OAB Last Modified Time
```

## More Information
