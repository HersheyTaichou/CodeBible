# Microsoft Wi-Fi Direct Virtual Adapter

This can sometimes cause issues and slow down network connections. Use these steps to disable it

1. Open an admin terminal window
2. Run the following commands

    ```bat
    netsh wlan stop hostednetwork
    netsh wlan set hostednetwork mode=disallow
    ```

3. Reboot
