<#
 .Synopsis
  Provides an easy way to manage the standard Office 365 modules

 .Description
  Provides commands that allow users to install, update, import or remove all of the 
  typical Office 365 and Entra ID modules at once

 .Parameter Module
  A module or array of module names to include

 .Example
   # Install the standard modules.
   Install-365Modules

 .Example
   # Add modules to install
   Install-365Modules -AddModules "Az","AzureAD"

 .Example
   # Update  the standard modules.
   Update-365Modules

 .Example
   # Add modules to install
   Update-365Modules -AddModules "Az","AzureAD"
#>
$BaseModules = @("Microsoft.Graph","Microsoft.Online.SharePoint.PowerShell","ExchangeOnlineManagement")

function Get-365Modules {
    [cmdletbinding()]
    param(
        [String[]]$AddModules
    )
    if ($AddModules) {
        $modules = $BaseModules + $AddModules
    } else {
        $modules = $BaseModules
    }
    $modules | ForEach-Object {Get-Module -Name $_ -ListAvailable}
}

function Install-365Modules {
    [cmdletbinding()]
    param(
        [Parameter()]
        [String[]]$AddModules
    )
    if ($AddModules) {
        $modules = $BaseModules + $AddModules
    } else {
        $modules = $BaseModules
    }
    $modules | ForEach-Object {Install-Module -Name $_}
}

function Update-365Modules {
    [cmdletbinding()]
    param(
        [Parameter()]
        [String[]]$AddModules
    )
    if ($AddModules) {
        $modules = $BaseModules + $AddModules
    } else {
        $modules = $BaseModules
    }
    $modules | ForEach-Object {Update-Module -Name $_}
}

function Import-365Modules {
    [cmdletbinding()]
    param(
        [Parameter()]
        [String[]]$AddModules
    )
    if ($AddModules) {
        $modules = $BaseModules + $AddModules
    } else {
        $modules = $BaseModules
    }
    $modules | ForEach-Object {Import-Module -Name $_}
}

Export-ModuleMember -Function Get-365Modules, Install-365Modules, Update-365Modules, Import-365Modules