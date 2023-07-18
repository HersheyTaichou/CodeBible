# Looping through an array with ForEach-Object

For use when you need to run a script on several results (dozens), and performing it manually would be time-consuming.

```PowerShell
$Table = Import-Csv C:\temp\table.csv
$Counter = 0

ForEach ($Row in $Table) {
    $Counter++
    Write-Progress -Activity 'Processing details' -CurrentOperation $Row -PercentComplete (($Counter / $Table.count) * 100)
    
    #Commands go here
    }
```

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
