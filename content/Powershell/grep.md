---
title: The PowerShell grep alternative
description: PowerShell has a command that provides similar function to grep in Linux.
---

PowerShell has a command that provides similar function to grep in Linux.

## Command

To take the contents of a file, search for a specific pattern, then output the results to another file:

```PowerShell
Select-String -Path "file.txt" -Pattern 'string' | Out-File results.txt
```

To take input from one command, search for a string, then output the results to the screen

```
Get-ChildItem | Select-String -Pattern 'string'
```
