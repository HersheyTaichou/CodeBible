# Clear OneDrive Registry keys/saved account

Delete any registry keys under HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive\Accounts, which start with “Business” but are not active. (i.e. “Business1, Business2, Personal")

To verify an active key select the key and in the right panel, you should see configurations for that Key. For example, if you select business1 there should be configurations for (default), Business, cid, ConfiguredTenantId, DisplayName etc...

If you look at the Business2 key, and it has no configurations, you can safely delete it.

You can also safely delete the personal key IF IT HAS NO CONFIGURATIONS.
