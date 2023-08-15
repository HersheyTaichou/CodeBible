<#
 .Synopsis
  Provides an easy way to connect to Partner tenant accounts

 .Description
  

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
$Script:Customers = @()
class Planet : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        Write-Host "Please log into the Partner Center"
        Connect-PartnerCenter
        $Script:Customers = Get-PartnerCustomer
        Return ($Script:Customers).Name
    }
}

function Connect-Service {
    param (
        [Parameter(Mandatory=$true)] [String]$Module,
        [Parameter(Mandatory=$true)] [ValidateSet([Customers])] [array]$Client
    )
    <#
    if ($Module -eq "ExchangeOnline") {
        Write-Host "Please log in to Exchange Online"
        Connect-ExchangeOnline -DelegatedOrganization $Client
    }elseif ($Module -eq "MgGraph") {
        Connect-MgGraph -TenantId $Client
    }
    #>
    write-host $client
}

Export-ModuleMember -Function Connect-Service