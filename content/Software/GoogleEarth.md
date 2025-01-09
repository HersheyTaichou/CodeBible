# Google Earth Pro

**Please Note**: Google Earth Pro Requires a paid subscription license and is not free for Business Use. Please ensure you have purchased a license prior to installing this application.

## How to Install

1. Download the [Direct installer from Google](https://support.google.com/earth/answer/168344#zippy=%2Cdownload-a-google-earth-pro-direct-installer)
2. Run the installer

## How to Deploy with Intune

### Step 1: Get the MSI

Unfortunately, Google does not provide the MSI for download, but it is available, briefly, during the install process

1. Prevent the installer from Deleting the MSI when it is done
   1. Open `%LocalAppData%` in Windows Explorer
   1. Right-click on the Temp folder, and open Properties
   1. Switch to the Security Tab
   1. Click Advanced at the bottom
   1. Click Add
   1. Click "Select a principal" and enter "Everyone"
   1. Switch "Type" to "Deny"
   1. Clear the checkboxes, then click "Show Advanced Permissions"
   1. Check off "Delete subfolders and files" and "Delete"
   1. Click OK through the dialogs
1. Go into the Temp folder
1. Run the installer for Google Earth Pro
1. Copy the "GoogleEarth-EC-x64.msi" file out from the temp folder
1. Open the security properties for Temp, then delete the deny permission we previously set.

### Step 2: Deploy with Intune

1. Log into Intune with an admin account
1. On the left, go to Apps > All Apps
1. Click + Add
   1. For "App type" select Other > Line-of-business app
   1. Click Select
1. Upload the MSI file we saved
1. Fill in any relevant details (Suggestions below)
   - Publisher: Google
   - Information URL: <https://www.google.com/earth/about/versions/>
   - Privacy URL: <https://policies.google.com/>
   - Logo: <https://www.google.com/intl/en_us/earth/about/assets/static/images/logo_google_earth_icon.svg>
1. Set the Scope Tags to match your environment
1. Set the Assignments to match your deployment strategy

## Sources

[Install Google Earth Pro Using Intune Step-By-Step Guide](https://www.anoopcnair.com/install-google-earth-pro-using-intune/)
