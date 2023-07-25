# Skype for Business Online

## Install the module

Download and install [Skype for Business Online, Windows PowerShell Module](https://www.microsoft.com/en-us/download/details.aspx?id=39366)

## Import the module

Normally, you should not need to import it, it should import automatically when you run commands.

```PowerShell
Import-Module -Name LyncOnlineConnector
```

## Connect to Skype for Business Online

You may need to adjust the execution policy to use the module

```PowerShell
Set-ExecutionPolicy -Scope Session -ExecutionPolicy Unrestricted -Force
$UserCredential = Get-Credential
$SFBsession = New-CsOnlineSession -Credential $UserCredential
Import-PSSession $SFBsession
```
