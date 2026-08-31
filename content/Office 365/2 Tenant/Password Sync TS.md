---
title: Troubleshoot AD Password Sync
---

Occasionally, the Office 365 portal will report that there is an issue with the password sync from the on-prem AD server.

## Prerequisites

You will need access to an account that has administrative access to the server running Azure AD Sync

## Process

First, you should make sure that the latest version of the Azure AD Connect Sync utility is installed on the server. You can check the latest version on the [Azure AD Connect: Version release history](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/connect/reference-connect-version-history) page.

If that does not resolve it, you will want to [Troubleshoot password hash synchronization with Azure AD Connect sync](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/tshoot-connect-password-hash-synchronization).
