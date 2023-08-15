# Get Message Tracking Logs

The on-prem equivalent of Message Trace logs

## Search for emails

First, you want to gather as much information about the email or groups of emails you are searching for, then search for all matching emails

```PowerShell
# Set the date and time for the start of the search
$Start = Get-Date -Date "2023/08/14 00:00:00"
# Set the date and time for the end of the search
$End = Get-Date -Date "2023/08/15 00:00:00"
$MessageTrackingLogs = Get-MessageTrackingLog -Sender "sender@domain.com" -Recipient "recipient@domain.com" -Start $Start -End $End
```

Some of the results contain embedded arrays, which are lost if exported to CSV or HTML. It is possible to retain them by exporting them to JSON and loading that into Excel

## Get the sending device

Adjust the above search to only capture the initial submission of the email. If you know the subject, add that as well, to reduce the number of results

```PowerShell
$MessageTrackingLogs = Get-MessageTrackingLog -Sender "sender@domain.com" -Recipient "recipient@domain.com" -Start $Start -End $End -EventId "Submit" -MessageSubject "Sent from the Mail app"
```

Then, extract the source context

```PowerShell
$results[0] | fl Timestamp,MessageSubject,SourceContext
```

This will give you a list that looks like the following

```text
Timestamp      : 8/14/2023 1:45:12 PM
MessageSubject : Sent from the Mail app
SourceContext  : MDB:ab1cd234-a5b6-7c89-a0b1-2dc345d6e7f8, Mailbox:12d34f56-7ec8-9eef-012c-a345678ef90b,
                 Event:55002956, MessageClass:IPM.Schedule.Meeting.Resp.Pos, CreationTime:2023-08-14T17:45:12.128Z,
                 ClientType:AirSync, SubmissionAssistant:MailboxTransportSubmissionEmailAssistant
```

The important thing to look at is the "ClientType", as that can give you a good idea of where that email was sent from

| Source                  | ClientType           |
|-------------------------|----------------------|
| iPhone/Android Mail app | AirSync              |
| Outlook Web Access      | OWA                  |
| Outlook                 | MOTM                 |
| Windows 10 Mail App     | AirSync              |
| Outlook for iOS/Android | ? (Best Guess, MOTM) |

## Sources

[Get-MessageTrackingLog](https://learn.microsoft.com/en-us/powershell/module/exchange/get-messagetrackinglog?view=exchange-ps)
