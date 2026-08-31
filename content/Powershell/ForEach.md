---
title: Working with foreach
---

For use when you need to run a script on several results (dozens) and performing it manually would be time-consuming.

## Prerequisites

Before running a `foreach` script, make sure you connect to any online services, if needed, for the commands in the `foreach` block

## Script

### foreach

Starting the top of the script:

1. We import the array from a CSV file with `Import-Csv`
2. We define a counter, which will allow us to show a progress bar
3. We start running through the array, looking at each row in the table
   1. We increment our counter, to show what entry in the array we are on
   2. We show a progress bar with details on what is going on
      - Activity is a text string shown to the user
      - Current Operation shows the Row contents
      - Percent complete shows how far we are
   3. We run any commands listed
   4. These steps are repeated until we run out of Rows in the Table

```PowerShell
$Table = Import-Csv C:\temp\table.csv
$Counter = 0

ForEach ($Row in $Table) {
    $Counter++
    Write-Progress -Activity 'Processing details' -CurrentOperation $Row -PercentComplete (($Counter / $Table.count) * 100)

    #Commands go here
    }
```

### ForEach-Object

`ForEach-Object` is similar to `foreach` but is designed to accept input piped to it. This allows you to run a command that returns an array, then you can do a task based on the items in the array.

Here is an example

```PowerShell
Get-Mailbox -ResultSize:Unlimited | ForEach-Object {Write-Host $_.DisplayName}
```

The above command will get all mailboxes in the organization, then print out the display name for every mailbox. $\_ is a shorthand for the data passed from the left side of the pipe ( | )

## More Information

[about_foreach](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach)

[ForEach-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object)
