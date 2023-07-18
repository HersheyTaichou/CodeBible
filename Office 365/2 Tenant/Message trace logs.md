# Message Trace logs

Use the following scripts to get all the message trace logs sent from a particular user to a particular user for a specificed length of time.

Update to the sender and recipient emails. Use *@domain.com to get everything sent to or from a particular domain

```PowerShell
$SenderAddress = "user@domain.com"
$RecipientAddress = "user@domain.com"
```

Update to the start and end dates of the search. Exchange online will go back to a maximum of 90 days by default

```PowerShell
$StartDate = (Get-Date -Hour 00 -Minute 00 -Second 00).AddDays(-90)
$EndDate = (Get-Date)
```

Searches are restricted to 5000 results, at most, at a time. To get more than that, we need to iterate through 'pages' of 5000 results.
We first define the variable everything will be stored in, tell it to start with page 1, and get 5000 results on each page.

```PowerShell
$messageTrace = @()
$page = 1
$pageSize = 5000
```

Now we loop through all the pages, until will we get to a blank page, and then stop

```PowerShell
do {
    Write-Progress -Activity 'Collecting all messages' -CurrentOperation $page
    $messagesThisPage = Get-MessageTrace -SenderAddress $SenderAddress -RecipientAddress $RecipientAddress -StartDate $StartDate -EndDate $EndDate -PageSize $pageSize -Page $page
    $messageTrace += $messagesThisPage
    $page++
} until ($messagesThisPage.count -eq 0)
```

Finally, we export the reults to a CSV, excluding internal results

```PowerShell
$messageTrace | Where-Object {$_.MessageId -notlike "*prod.outlook.com>"} | export-csv "C:\temp\MessageTrace $(Get-date -Format 'yyyy-MM-dd').csv"
```
