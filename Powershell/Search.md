# How to search for files with Powershell

The following is a basic script to search for files with specific terms in the title or path. For more advanced filters, check the linked documentation.

```PowerShell
$Path = "C:\Path\To\Folder"
$Include = @("Search Term 1","Search Term 2")
Get-Childitem –Path $Path -Include $Include -Recurse -ErrorAction SilentlyContinue
```

## Documentation

[Get-Childitem](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem)  
[Use Windows PowerShell to search for files](https://devblogs.microsoft.com/scripting/use-windows-powershell-to-search-for-files/)
