# Active Directory Audit Logs

## Prerequisites

To perform these steps, you will need access to a domain controller with Administrative permissions to that server.

## Process

### Enable Active Directory Auditing through Group Policy

1. From the domain controller, open "Group Policy Management"
1. Either create a new GPO (recommended) or select an existing one
   - It is easiest to create a new one by right-clicking on the domain name, then clicking "Create a GPO in this domain, and Link it here..."
   - Name the group following any standards for the company with an explanation of what it does. "Domain - Audit Logging" for example.
1. Right-click the new GPO and click Edit
1. Browse to the following location:  
   `Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\Audit Policy`
1. Open the properties for "Audit account management"
   1. Check "Define these policy settings"
   1. Check "Success" and "Failure"
   1. Click OK at the bottom
1. Close the "Group Policy Management Editor"
1. If you did not previously, link it to the OU that contains your domain controllers, or at the top level of the domain.
1. In the GPO's Scope tab, under Security Filtering, add the "Everyone" group

### Enable Auditing of Active Directory through ADSI edit

1. Open "ADSI Edit"
1. Go to Action > Connect to...
1. Make sure it is set to the "Default naming context" then click OK
1. Expand the "Default naming context" then right-click on the domain
1. Open the Properties window
1. Switch to the security tab, and click "Advanced"
1. Switch to the auditing tab
1. Either select the Everyone entry or click Add
1. Check off the Full Control box
1. Now uncheck the following boxes
   - Full Control
   - List Contents
   - Read all properties
   - Read permissions

### Track changes through Event Viewer

1. Open Event Viewer and go to `Windows Logs\Security`
1. On the right, click the "Filter Current Log..." button
1. In the "\<All Event IDs\>" box, enter the Event IDs you are looking for.

    <details>
    <Summary>Table of Event IDs</Summary>
    | Event ID | Event ID Description                                               |
    |----------|--------------------------------------------------------------------|
    | 4661     | A handle for an object was requested                               |
    | 4662     | An operation was performed on an object.                           |
    | 4720     | A user account was created.                                        |
    | 4722     | A user account was enabled.                                        |
    | 4723     | An attempt was made to change an account's password                |
    | 4724     | An attempt was made to reset an account's password                 |
    | 4725     | A user account was disabled.                                       |
    | 4726     | A user account was deleted.                                        |
    | 4727     | A security-enabled global group was created.                       |
    | 4728     | A member was added to a security-enabled global group              |
    | 4729     | A member was removed from a security-enabled global group          |
    | 4730     | A security-enabled global group was deleted.                       |
    | 4731     | A security-enabled local group was created.                        |
    | 4732     | A member was added to a security-enabled local group               |
    | 4733     | A member was removed from a security-enabled local group           |
    | 4734     | A security-enabled local group was deleted,                        |
    | 4735     | A security-enabled local group was changed.                        |
    | 4737     | A security-enabled global group was changed.                       |
    | 4738     | A user account was changed.                                        |
    | 4740     | A user account was locked out.                                     |
    | 4741     | A computer account was created.                                    |
    | 4742     | A computer account was changed.                                    |
    | 4743     | A computer account was deleted.                                    |
    | 4744     | A security-disabled local group was created                        |
    | 4745     | A security-disabled local group was changed                        |
    | 4746     | A member was added to a security-disabled local group              |
    | 4747     | A member was removed from a security-disabled local group          |
    | 4748     | A security-disabled local group was deleted.                       |
    | 4749     | A security-disabled global group was created                       |
    | 4750     | A security-disabled global group was changed.                      |
    | 4751     | A member was added to a security-disabled global group             |
    | 4752     | A member was removed from a security-disabled global group         |
    | 4753     | A security-disabled global group was deleted.                      |
    | 4754     | A security-enabled universal group was created.                    |
    | 4755     | A security-enabled universal group was changed.                    |
    | 4756     | A member was added to a security-enabled universal group           |
    | 4757     | A member was removed from a security-enabled universal group       |
    | 4758     | A security-enabled universal group was deleted.                    |
    | 4759     | A security-disabled universal group was created.                   |
    | 4760     | A security-disabled universal group was changed.                   |
    | 4761     | A member was added to a security-disabled universal group          |
    | 4762     | A member was removed from a security-disabled universal group      |
    | 4763     | A security-disabled universal group was deleted.                   |
    | 4764     | A group type was changed.                                          |
    | 4767     | A user account was unlocked.                                       |
    | 4780     | The ACL was set on accounts that are members of administrators     |
    | 4781     | The name of an account was changed.                                |
    | 4794     | An attempt was made to set the Directory Services Restore Password |
    | 5136     | A directory service object was modified                            |
    | 5137     | A directory service object was created                             |
    | 5138     | A directory service object was undeleted                           |
    | 5139     | A directory service object was moved                               |
    | 5139     | A directory service object was moved                               |
    | 5141     | A directory service object was deleted                             |
    | 5376     | Credential Manager credentials were backed up                      |
    | 5377     | Credential Manager credentials were restored from a backup         |
    </details>

1. Here is an example entry from Event Viewer, which shows **Kelly**, a user account, was added to **VPN-Access**, a security group, by **AdminMike**, an account with administrative access to the domain.

    ```text
    A member was added to a security-enabled global group.

    Subject:
        Security ID:        DOMAIN\AdminMike
        Account Name:       AdminMike
        Account Domain:     DOMAIN
        Logon ID:           0x5376C28F

    Member:
        Security ID:        CORDIA\Kelly
        Account Name:       CN=Kelly Smith,OU=Users,OU=Company,DC=domain,DC=com

    Group:
        Security ID:        DOMAIN\VPN-Access
        Group Name:         VPN-Access
        Group Domain:       DOMAIN

    Additional Information:
        Privileges:         -
    ```

## More Information

This process was adapted from the steps available on Lepide, which can be found at [How to Audit Active Directory Group Membership Changes](https://www.lepide.com/how-to/track-and-audit-active-directory-group-membership-changes.html)
