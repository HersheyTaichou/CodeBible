# Test SMTP Settings

This can be useful when setting up a scan to email device, and you are having trouble getting it to work.

```PowerShell
$UserCredential = Get-Credential
Send-MailMessage -From "source@domain.com" -To "Destination@domain.com" -Subject (Get-Date) -Body "Test Email" -SmtpServer "smtp.office365.com" -Credential $UserCredential -UseSsl -Port 587
```

**NOTE:** This command is being deprecated.

Documentation

[Send-MailMessage](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/send-mailmessage)
