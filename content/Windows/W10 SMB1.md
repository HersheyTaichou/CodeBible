# Enable SMB1 on Windows 10

Starting with Windows 10 Fall Creator's update (1709) SMB1 protocol is disabled by default. It can be re-enabled in one of two ways

## Enable it in Windows Features

1. Open the Start Menu
2. Search for "Turn Windows Features On or Off"
3. Scroll down and expand "SMB 1.0/CIFS File Sharing Support"
4. Check off "SMB 1.0/CIFS Client" to connect to an SMB1 share
5. Check off "SMB 1.0/CIFS Server" to allow SMB1 clients to connect to your shares

## Enable in the registry

1. Open RegEdit
2. Go to HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters
3. Open or create AllowInsecureGuestAuth
   - It should be a REG_DWORD
4. Set it to 1
