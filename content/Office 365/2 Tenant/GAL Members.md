---
title: GAL Membership Lists
description: Get all members of the GAL
---
Use this to get a CSV with all the emails in Exchange Online, including if they are in the GAL or not.

## Prerequisites

Before running this script, you will need to connect to the [[ExchangeOnlineManagement|Exchange Online PowerShell Module]]

## Script

```PowerShell
$EXORecipient = Get-EXORecipient -ResultSize Unlimited

foreach($recipient in $EXORecipient){

    foreach($emailaddress in [array]$recipient.emailaddresses){

                ##new hashtable
                $hash = [ordered]@{
                    "DisplayName" = DisplayName
                    "PrimarySmtpAddress" = $recipient.PrimarySmtpAddress
                    "emailaddress" = $emailaddress
                    "HiddenFromAddressListsEnabled" = $recipient.HiddenFromAddressListsEnabled
                    "RecipientTypeDetails" = $recipient.RecipientTypeDetails
                }

                
                ##Convert hashtable to PSCustomObject
                $obj = New-Object -TypeName psobject -Property $hash

                ##Export to CSV
                $obj | Export-Csv -Path "C:\Temp\AllEmailAddresses.csv" -Append -NoTypeInformation
    }
}
```

## More Information

This was adapted from a script written by Sean McAvinue. The original can be found on his [GitHub](https://github.com/smcavinue/AdminSeanMc/blob/master/Exchange%20Online%20Scripts/Get-AllemailAddresses.ps1)
