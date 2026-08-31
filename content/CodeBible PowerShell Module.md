---
title: CodeBible PowerShell Module
description: A PowerShell module to make it easy to run some of the longer or more complicated scripts.
---

Some of the longer scripts have been converted into proper PowerShell functions and added to a module, which can be found on in a dedicated GitHub repo, [HersheyTaichou/CodeBible-Module](https://github.com/HersheyTaichou/CodeBible-Module)

## Prerequisites

Some of the modules require other modules as dependencies, for example, [ExoMailbox.psd1](https://github.com/HersheyTaichou/CodeBible-Module/blob/main/ExoMailbox/Source/ExoMailbox.psd1) requires [[ExchangeOnlineManagement]]

## How to Install

1. Download a copy of the repo from GitHub
   1. Optional: Save it in the Documents\PowerShell folder
2. Open PowerShell 7
   - The scripts were built with PowerShell 7 and may not behave as expected in PowerShell 5
3. Run `Import-Module {Path to PSD file for the module}`
