# Add msExchHideFromAddressLists to the Entra ID Sync

In new deployments of AD, that did not have an Exchange server on-premise, the `msExchHideFromAddressLists` may not be present for AD users, which prevents you from syncing that field from AD when Entra ID Sync is setup.

The fix for this is to set a different attribute for the user, then tell the Sync rules to make `msExchHideFromAddressLists True` if that value is set.

## Steps

1. Log into the server or computer that manages the sync
2. Open the Synchronization Rules Editor as an admin
3. Make sure the direction is set to Inbound, then click Add new rule.  
   ![Image of the settings](../../Resources/images/HideFromGAL1.png)
4. Under Description, set the following, then click Next
   - Name: msExchHideFromAddressLists
     - Can be anything descriptive
   - Description: If the msDS-CloudExtensionAttribute1 attribute is set to HideFromGAL, hide from the Exchange Online GAL
     - Can be anything descriptive
   - Connected System: domain.local
     - The company's local domain name
   - Connected System Object Type: user
   - Metaverse Object Type: Person
   - Link Type: Join
   - Precedence: 50
     - can be any number under 100, 50 is the default.
     - **Do not duplicate numbers!**
   - Tag:
     - Can be left blank
   - Enable Password Sync: Leave unchecked
   - Disabled: Leave unchecked
5. Scoping Filter: Leave this page as-is and click Next
6. Join rules: Leave this page as-is and click Next
7. Transformation: Click Add Transformation, then do the following
   1. Set the FlowType to Expression
   2. Set the Target Attribute to msExchHideFromAddressLists
   3. Set the Source to the following expression  
      `IIF(IsPresent([msDS-cloudExtensionAttribute1]),IIF([msDS-cloudExtensionAttribute1]="HideFromGAL",True,False),NULL)`
   4. Set Merge Type to Update
8. Click Save at the bottom
9. Open an admin PowerShell prompt and run an initial sync  
   `Start-ADSyncSyncCycle -PolicyType Initial`

Make sure to go back and set the `msDS-cloudExtensionAttribute1` attribute to "HideFromGAL" for any users that should be hidden from the GAL. Also, remember that HideFromGAL is case sensitive

## References

[msExchHideFromAddressLists attribute isn't syncing across to Azure](https://social.msdn.microsoft.com/Forums/azure/en-US/8ef659e8-da58-4c5e-acad-2799f4b864c2/msexchhidefromaddresslists-attribute-isnt-syncing-across-to-azure?forum=WindowsAzureAD)
