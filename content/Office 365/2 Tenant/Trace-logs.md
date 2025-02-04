---
title: Message Trace Logs
description: This article details how to search message transport logs in Exchange Online
---

This article details how to search message transport logs in Exchange Online

## Prerequisites

These scripts require the #ExchangeOnlineManagement module.

## Command(s)/Script(s)/Process

This will pull logs from the last 90 days

```PowerShell
$SenderAddress = "*@domain.com"
$RecipientAddress = "*@domain.com"
$StartDate = (Get-Date -Hour 00 -Minute 00 -Second 00).AddDays(-90)
$EndDate = (Get-Date -Hour 00 -Minute 00 -Second 00)

$messageTrace = @()
$page = 1
$pageSize = 5000

$messageTrace = do
{
	Write-Progress -Activity 'Collecting all messages' -CurrentOperation $page
	$messagesThisPage = Get-MessageTrace -SenderAddress $SenderAddress -RecipientAddress $RecipientAddress -StartDate $StartDate -EndDate $EndDate -PageSize $pageSize -Page $page
	$messagesThisPage
	$page++
}
until ($messagesThisPage.count -eq 0)

$messageTrace | Where-Object {$_.MessageId -notlike "*prod.outlook.com>"} | export-csv "MessageTrace $(date -Format 'yyyy-MM-dd').csv"
```
