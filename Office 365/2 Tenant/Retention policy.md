# Retention Policies

Retention policies govern the rules on what emails are automatically archived and deleted. They also govern what rules the users have access to for automatic archival and deletion

## Prerequisites

You will need access to the company's Office 365 Tenant with an account that has the requisite permissions to make changes in the Exchange Admin Center and the Compliance Center.

## Processes

### Checking a Policy's settings

1. Get the policy name applied to a user
   1. Log in to the Exchange Admin Center
   1. On the left, go to Recipients > Mailboxes
   1. Search for the user you want to check the policy for
   1. Click on them and switch to the mailbox tab
   1. Go down to Mailbox policies > Retention policy
   1. Note the policy name
1. Check the Policy retention tags
   1. Log into the Compliance Center
   1. On the left, go to Data lifecycle management > Exchange (legacy)
   1. Click on the policy name that you noted previously
   1. Make a note of all the tags listed under the policy
1. Check the retention tags settings
   1. At the top of the Exchange (legacy) page, switch to the "MRM Retention tags" page
   1. For each tag noted above, check the settings
      - **Type:** How the rule is applied
         - **Personal:** Applied by the user to specific folders
         - **Default:** Applied to all folders in the mailbox, but can be overridden by a Personal or folder name policy
         - **"Folder name":** Applied by default to the named folder, but can be overridden by a Personal policy
      - **Retention Period:** How long before the Retention Action takes effect
      - **Retention Action:** The action to take with the email
      - Three example rules are below:

        | Name | Type | Retention Period | Retention Action | Explanation |
        |------|:----:|:----------------:|:----------------:|-------------|
        | 1 Month Delete | Personal | 30 days | Delete | On any folder the user enables this policy on, delete any emails over 30 days |
        | Default 2 year move to archive | Default | 730 days | Archive | For any email over 2 years old, move the email into the online archive,  if enabled, unless another policy is applied to that folder |
        | Junk Email | Junk Email | 30 days | Delete | Delete any email in the Junk Email folder that is over 30 days old |

### Creating a new policy

1. Create any needed Retention tags
   1. Log into the Compliance Center
   1. On the left, go to Data lifecycle management > Exchange (legacy)
   1. Switch to the "MRM Retention tags" page
   1. Click the "+ New tag" button
      1. Give the tag a good name, add a description, and click Next
         - **Example name:** Default 1-year move to archive
         - **Example description:** Move any emails older than a year into the online archive
      1. Select the option that fits your need
         - **Example:** Automatically to entire mailbox (default)
      1. Set the Retention Period and Action
         - **Example Retention Period:** When items reach the following age (in days)  
         365
         - **Example Retention Action:** Move item to archive
   1. Repeat for any other needed retention tags
1. Create a new Retention policy
   1. Switch to the "MRM Retention Policies" page
   1. Click the "+ New policy" button
      1. Give the tag a good name and click Next
         - **Example name:** Default 1-year archive
      1. Under Tags click Edit
      1. Click "+ Add tag"
      1. Check off any tags that should be available or applied then click add
         - Tip: Check off all the Personal tags, so the user has more options
      1. Click Next and Submit
1. Apply the policy to a user
   1. Log in to the Exchange Admin Center
   1. On the left, go to Recipients > Mailboxes
   1. Search for the user you want to check the policy for
   1. Click on them and switch to the mailbox tab
   1. Go down to "Mailbox policies" and click on "Manage Mailbox Policies"
   1. Under Retention Policy, click the dropdown and switch the policy

## Run the Policies

Use this command to force the applied policies to run on a mailbox

```PowerShell
Start-ManagedFolderAssistant -Identity "User@domain.com"
```
