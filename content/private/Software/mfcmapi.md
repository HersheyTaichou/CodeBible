# MFCMAPI Tool

This tool allows you to open an Exchange mailbox synced on the local machine, and see all the hidden files and folders, to restore files and folders that have been deleted or lost in the last sync.

## How to Install

Download the latest release from the [Microsoft GitHub](https://github.com/microsoft/mfcmapi/releases/)

Most likely you will want the MFCMAPI.x64.exe.{version}.zip file

Extract the zip file and run MFCMapi.exe. It is a portable application, so you will not need to install anything and it can be stored on a flash drive.

## How to Use

### How to Open and Review a Mailbox

In MFCMapi, click on Session > Logon then select the Outlook profile to connect to. Double-click the email address you want to work with. This will open a second window with the user's entire mailbox, including any hidden folders.

### To Find and Restore Deleted Items

Open a mailbox as detailed above, then go to Actions > Other Tables > Deleted Contents

Everything deleted but not purged from the mailbox should still be here.

You can search by any properties of the message by clicking on Search > Search at the top. It will default to "PR_SUBJECT". To select a different property, click on "Select Property Tag" at the bottom, then "Select Property Tag" at the bottom of the new window. Here are some useful property tags:

| Name | Detail |
| ---- | ------ |
| PR_SUBJECT| The email subject |
| PR_SENDER_EMAIL_ADDRESS | The sender's email address |
