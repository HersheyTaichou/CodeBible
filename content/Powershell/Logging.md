---
title: Logging in PowerShell Scripts
description: This article contains various ways you can log the output from a script to a machine or file.
---

This article contains various ways you can log the output from a script to a machine or file.

## Processes

### Save Terminal Output to a file

> "The Start-Transcript cmdlet creates a record of all or part of a PowerShell session to a text file. The transcript includes all commands that the user types and all output that appears on the console."  
> &mdash; <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.host/start-transcript>

Place the following command at the beginning of your script or the batch of commands you will be running:

```PowerShell
Start-Transcript -Path c:\temp\output.log -Append
```

Remove `-Append` if you want the file replaced each time

Then place this command at the end of your script or batch of commands

```PowerShell
Stop-Transcript
```

### Save Details to Event Viewer

#### Create a Log Source

First, you need to create a new log source. You should only have to run this once per machine, per source name.

```PowerShell
New-EventLog -LogName "System" -Source "Script" -ErrorAction "SilentlyContinue"
```

First, you will want to change `-LogName` to the Event Log you want the logs saved to. The defaults are "Application", "Security", "Setup", and "System". Alternatively, you can create a new log, which can be found in Event Viewer under "Applications and Services Logs".

Second, you define the `-Source` for your logs. This must be a unique string across all the system's Event Logs.

#### Write Logs

Now that we have a source established for our logs, we want to send entries to Event Viewer:

```PowerShell
$EventID = 1234
$message = "This is the message we are logging."
Write-EventLog -LogName "System" -Source "Script" -EntryType "Information" -EventId $EventID -Message $message
```

- First, we tell it the log name and source we previously set.
- Second, we tell it what type of entry it is ([See the Options here](https://learn.microsoft.com/en-us/dotnet/api/system.diagnostics.eventlogentrytype?view=windowsdesktop-7.0#fields)).
- Next, we put in the Event ID, which helps with filtering in Event Viewer and can be used to help the end user with researching errors for more info.
- Then, finally, we tell it what the actual log message is

## More Information

[Start-Transcript](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.host/start-transcript)
