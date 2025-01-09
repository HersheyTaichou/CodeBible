# Various Tasks Related to Logins

## Hide a Windows Login Account from the Login Screen

1. Open RegEdit
2. Go to HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
3. Right-click Winlogon and click New > Key
4. Name the new key SpecialAccounts
5. Right-click the SpecialAccounts key and click New > Key
6. Name the new key UserList
7. Inside of UserList, right-click and select New > DWORD (32-bit) Value
8. Name the new DWORD key with the name of the account you're trying to hide.
9. Double-click the new DWORD key and make sure its data value is set to 0.
10. Sign-out and you'll now notice that the account will no longer be available on the sign-in screen.

## Restore Missing Users on the Login Screen

### With the Terminal

1. Open an admin terminal
2. Run the following command

    ```bat
    secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
    ```

3. Reboot

### User Local Users and Groups

1. Press Windows Key + R, type `lusrmgr.msc`, and click OK.
2. Now click the Group section, right-click on Administrators and pick Add to Group.
3. In the Properties window, click Add
4. Then in the Select Users window, click on Object Types.
5. Now in the following window, select Users and uncheck other options here. Click OK.
6. After clicking OK, we’re back to the Select Users window. Now click on Advanced there
7. On this window, click Find Now.
8. From Search Results, find and select the username not appearing on the Login screen/Start Menu username drop-down menu. Click OK. Again click OK
9. Reboot
