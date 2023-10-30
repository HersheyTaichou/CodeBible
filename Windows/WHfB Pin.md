# Unable to Set/Change Pin for Windows Hello for Business

make a copy of the following folder:  
C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc

Then delete the contents of that folder

Open settings and try setting a pin now

## Set Registry Key

Set the following key to enable pin sign-in if it isn't enabled

```text
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System\AllowDomainPINLogon
```

## Source

<https://superuser.com/questions/1279400/unable-to-set-or-remove-a-login-pin-on-windows-10>
