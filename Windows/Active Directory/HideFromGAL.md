# Add msExchHideFromAddressLists to the Entra ID Sync

In new deployments of AD, that did not have an Exchange server on-premise, the `msExchHideFromAddressLists` may not be present for AD users, which prevents you from syncing that field from AD when Entra ID Sync is setup.

The fix for this is to set a different attribute for the user, then tell the Sync rules to make `msExchHideFromAddressLists True` if that value is set.

## Steps

1. Log into the server or computer that manages the sync
2. Open the Synchronization Rules Editor as an admin
3. Make sure the direction is set to Inbound, then click Add new rule.  
    ![Image of the settings](..\..\Resources\HideFromGAL1.png)
4. 
