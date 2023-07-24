# Hide a Windows Login Account from the Login Screen

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
