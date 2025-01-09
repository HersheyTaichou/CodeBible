# Organization Relationships

This is the process to set up an organizational relationship, which is primarily used to share some calendar details between two different organizations.

## Prerequisites

You will need access to one or both of the company's Office 365 Tenants with an account that has the requisite permissions to make changes in the Exchange Admin Center. To troubleshoot, you will need to log in to [Exchange Online](../1%20Global/ExchangeOnlineManagement.md) in PowerShell

## Process

### Use the Exchange admin center to create an organizational relationship

Before starting, it is recommended that you create a mail-enabled security group to restrict who is allowed to share their calendar externally.

1. From the Office 365 admin center dashboard, go to Admin > Exchange.
2. Go to Organization > Sharing.
3. Under Organization Sharing, click "Add organization relationship"
4. Under "Create a relationship", in the Relationship name box, type a friendly name for the organization relationship.
5. In the Domains to share with box, type the domain for the external Office 365 or Exchange on-premises organization you want to let see your calendars. If you need to enter more than one domain, separate the domain names with a comma. For example, contoso.com, service.contoso.com.
6. Select the Enable calendar free/busy information sharing check box to turn on calendar sharing with the domains you listed.
   1. Set the sharing level for calendar free/busy information
   2. Set which users can share calendar free/busy information.
7. Click save to create the organization relationship.

## More Information

### Troubleshoot an Organizational Relationship

In a perfect world the other organization will create the reciprocated organizational relationship and then end users can happily share calendar information.  Often found this is rarely the case so here are some troubleshooting steps which might make life a little easier:

First, let’s validate the federation information. This is done in PowerShell using Exchange Online.  
When connected to O365/PS you can view the federation information of any O365 tenant.  You don’t need to be given any explicit access to do this.  The following command is used:

```PowerShell
Get-FederationInformation -DomainName domain.com -BypassAdditionalDomainValidation
```

The output should look like the following.

```text
TargetApplicationUri  : outlook.com
DomainNames           : {munich.microsoft.com, video2brain.com, exchange.microsoft.com, preonboarding.microsoft.com…}
TargetAutodiscoverEpr : https://autodiscover-s.outlook.com/autodiscover/autodiscover.svc/WSSecurity
TokenIssuerUris       : {urn:federation:MicrosoftOnline}
IsValid               : True
ObjectState           : Unchanged
```

Pay particular attention to the TargetApplicationUri, DomainNames, and TargetAutodiscoverEpr fields. We want to confirm those fields match what was set for the organizational relationship.

Next, we want to get the details of the relationship on our end

```PowerShell
Get-OrganizationRelationship -Identity "relationship name" | fl
```

The output should look like the following

```text
DomainNames                 : {munich.microsoft.com, video2brain.com, exchange.microsoft.com, preonboarding.microsoft.com…}
FreeBusyAccessEnabled       : True
FreeBusyAccessLevel         : AvailabilityOnly
FreeBusyAccessScope         : Group Name
MailboxMoveEnabled          : False
MailboxMoveCapability       : None
MailboxMovePublishedScopes  : {}
IdentityMoveEnabled         : False
IdentityMoveCapability      : None
IdentityMovePublishedScopes : {}
PeopleSearchEnabled         : False
PeopleSearchCapability      : None
PeopleSearchPublishedScopes : {}
OAuthApplicationId          :
DeliveryReportEnabled       : False
MailTipsAccessEnabled       : False
MailTipsAccessLevel         : None
MailTipsAccessScope         :
PhotosEnabled               : False
TargetApplicationUri        : outlook.com
TargetSharingEpr            :
TargetOwaURL                :
TargetAutodiscoverEpr       : https://autodiscover-s.outlook.com/autodiscover/autodiscover.svc/WSSecurity
OrganizationContact         :
Enabled                     : True
```

Make sure the details from Get-FederationInformation match the details from Get-OrganizationRelationship.

The next thing we want to do is test the relationship, which is done with the following command:

```PowerShell
Test-OrganizationRelationship -UserIdentity <internal email> -Identity <org relationship name> -verbose
```

This will tell us if there is anything wrong with the relationship between the two tenants.

```text
VERBOSE: Returning precomputed version info: 3.2.0
VERBOSE: HTTP/1.1 POST with 157-byte payload
VERBOSE: received 890-byte response of content type application/json
VERBOSE:

Begin testing for organization relationship CN=Company,CN=Federation,CN=Configuration,CN=Domain.onmicrosoft.com,CN=ConfigurationUnits,DC=NAMPR12A345,DC=PROD,DC=OUTLOOK,DC=COM, enabled state True.

Exchange D-Auth Federation Authentication STS Client Identities are uri:WindowsLiveID/outlook.com;urn:federation:MicrosoftOnline/outlook.com;

STEP 1: Validating user configuration

RESULT: Success.

STEP 2: Getting federation information from remote organization...

RESULT: Success.

STEP 3: Validating consistency in returned federation information

RESULT: Success.

STEP 4: Requesting delegation token from the STS...

RESULT: Success.
Retrieved token for target https://autodiscover-s.outlook.com/autodiscover/autodiscover.svc/WSSecurity for offer Name=MSExchange.Autodiscover,Duration=28800(secs)

STEP 5: Getting organization relationship setting from remote partner...

RESULT: Success.

STEP 6: Validating organization relationships returned from remote partner
RESULT: Success.

LAST STEP: Writing results...
No Significant Issues to Report

COMPLETE.
```

### Extended Troubleshooting

Now is probably an appropriate time to find out if the other tenant has a hybrid environment and if it is set up correctly. The best way to validate is if the online and on-prem can share calendar information.  If this is the case then the additional domain of domain.mail.onmicrosoft.com may also need to be included in the list of domains for the org relationship.  But this should also come up when viewing the federated info.
If this is not the case then it is down to a permissions issue.

When using the scheduler in Outlook, unless specified, the account that is being used is the default user.  The permissions for the default user cannot be set to "none".

Permissions that only apply to calendars are:

- AvailabilityOnly: View only availability data
- LimitedDetails: View availability data with subject and location

To show what is currently set for the calendar:

```PowerShell
Get-MailboxFolderPermission alias:\calendar
```

If your calendar permissions for the default user are set to none on every mailbox then we can use the following command/script to fix that:

```PowerShell
$users = Get-Mailbox -Resultsize Unlimited
foreach ($user in $users) { Set-MailboxFolderPermission -Identity "$($user.alias):\calendar" -User Default -AccessRights AvailabilityOnly }
```

This will traverse each mailbox and make permission changes where needed and throw a warning (per mailbox) if no changes get made.  This also applies to rooms etc.

Calendar sharing should now be functional.

Of course, there are more customizable options when setting up organizational relationships, etc but this is the majority of it when it comes to setup/troubleshooting.

Are you still having issues? Call Microsoft
