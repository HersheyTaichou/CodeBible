---
title: Microsoft Entra Connect Custom Sync Rules
description: How to add custom sync rules in Microsoft Entra Connect
---

This document covers how to create custom sync rules for #Microsoft-Entra-Connect. This can be useful to sync specific fields from Active Directory to Entra ID

## Prerequisites

Administrative access to the server with Azure AD Sync installed

## Process

### Syncing the Account's Department Field to Exchange

This is useful when you want to create dynamic distribution groups based on a user's department

1. Log into the server with Azure AD Sync installed
1. Open Synchronization Rules Editor
1. Click "Add a Rule"
   1. Fill in the details on the General page
      - **Name**: Sync Department to CustomAttribute1
      - **Description**: Set according to your standards, such as a reference to a help ticket number
      - **Connected System**: the local domain
      - **Connected System Object Type**: User
      - **Metaverse Object Type**: Person
      - **Link Type**: Join
      - **Precedence**: 50 or the next number up, if 50 is taken
   1. Proceed to the Transformations Page
   1. Click **Add Transformation**
      - **FlowType**: Direct
      - **Target Attribute**: ExtensionAttribute1
      - **Source**: Department
      - Leave the other settings as-is
1. Open PowerShell as an admin
1. Run an initial Sync

   ```PowerShell
   Start-ADSyncSyncCycle -PolicyType Initial
   ```

You can now create or edit rules based on departments by using the CustomAttribute1 field in Exchange Online
