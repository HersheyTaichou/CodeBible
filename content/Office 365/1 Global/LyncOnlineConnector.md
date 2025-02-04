---
title: Skype for Business Online PowerShell Module
---

> [!Deprecated] This module has been superseeded by the #MicrosoftTeams module.

This module is used to connect to Skype for Business Online and manage it through PowerShell.

## Prerequisites

### Install the module

Unlike most other modules, this one is not installed from a public repository and has to be manually downloaded and installed.

You can download it from Microsoft's [Skype for Business Online, Windows PowerShell Module](https://www.microsoft.com/en-us/download/details.aspx?id=39366) page

### Import the module

Normally, you should not need to import it, it should import automatically when you run commands.

```PowerShell
Import-Module -Name LyncOnlineConnector
```

## Commands

### Connect to Skype for Business Online

You may need to adjust the execution policy to use the module

```PowerShell
Set-ExecutionPolicy -Scope Session -ExecutionPolicy Unrestricted -Force
$UserCredential = Get-Credential
$SFBsession = New-CsOnlineSession -Credential $UserCredential
Import-PSSession $SFBsession
```
