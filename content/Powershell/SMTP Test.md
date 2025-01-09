# Test SMTP Settings

This allows you to send an SMTP email message from a local device, to test if the credentials or setup is working

This can be useful when setting up a scan to email device, and you are having trouble getting it to work.

## Commands

**NOTE:** This command is being deprecated.

```PowerShell
$UserCredential = Get-Credential
Send-MailMessage -From "source@domain.com" -To "Destination@domain.com" -Subject (Get-Date) -Body "Test Email" -SmtpServer "smtp.office365.com" -Credential $UserCredential -UseSsl -Port 587
```

## More Information

[Send-MailMessage](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/send-mailmessage)
