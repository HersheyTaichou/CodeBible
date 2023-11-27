# CodeBible PowerShell Module

## Introduction

This module is intended to make it easier to run some of the scripts present in this repository.

## Getting Started

Import the module with the following command

```PowerShell
Import-Module CodeBible.psd1
```

The commands do have help text, to remind you of what they can do and the options they have

## Commands

### Get-ForwardRules

Get Any Outlook Rules to Forward Emails

Searches each mailbox and returns any rules to forward emails. It will retrieve all forwards by default but can be restricted to external forwards only

```PowerShell
Get-ForwardRules
```

### Repair-WindowsInstall

Run a repair of Windows

Uses DISM, SFC and CHKDSK to check for issues in Windows and repair them, if possible.

```PowerShell
Repair-WindowsInstall
```

## Contribute

I am always open to suggestions or improvements to the scripts in this module.

Please use the issues tab at the top of the repository on GitHub to suggest any improvements or problems found.

And as always, Thank you!
