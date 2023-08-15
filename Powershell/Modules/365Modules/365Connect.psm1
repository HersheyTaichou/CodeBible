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
class Customers : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        If (Test-Path "customers.json") {
            $Script:Customers = Get-Content -Raw customers.json | Convertfrom-Json
        } else {

        }
        Return ($Script:Customers).Name
    }
}

function Get-AvailableCustomers {
    Write-Host "Please log into the Partner Center"
    Connect-PartnerCenter
    $Script:Customers = Get-PartnerCustomer
    $Script:Customers | ConvertTo-Json | Out-File customers.json
        
}

function Connect-Service {
    param (
        [Parameter(Mandatory=$true)] 
        [ValidateSet("ExchangeOnline","MgGraph")]
            [String]$Module,
        [Parameter(Mandatory=$true)] [ValidateSet([Customers])] [array]$Client
    )
        if ($Module -eq "ExchangeOnline") {
        Write-Host "Please log in to Exchange Online"
        $Domain = ($Script:Customers | Where-Object {$_.Name -eq "$Client"}).Domain
        Write-Host $CustomerId
        Connect-ExchangeOnline -DelegatedOrganization $Domain
    }elseif ($Module -eq "MgGraph") {
        #Connect-MgGraph -TenantId $CustomerId
        $CustomerId = ($Script:Customers | Where-Object {$_.Name -eq "$Client"}).CustomerId
        Write-Host $CustomerId
    }
}

Export-ModuleMember -Function Connect-Service, Get-AvailableCustomers