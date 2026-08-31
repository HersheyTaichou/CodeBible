# Rename files with invalid characters

Use the following script to rename any files that have unsupported or invalid characters in the name, so it will let you move them into OneDrive and sync successfully

```PowerShell
$folder = 'c:\test'
Get-ChildItem $folder -Recurse | ? {$_ -match '%|#|_|-'} | sort psiscontainer, {$_.fullname.length * -1} | % {ren $_.FullName $($_.name -replace '%|#' -replace '_', ' ')}
```
