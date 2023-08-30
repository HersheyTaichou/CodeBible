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
        If (Test-Path "$env:appdata\Azure\customers.json") {
            $Script:Customers = Get-Content -Raw customers.json | Convertfrom-Json
        } else {
            Get-AvailableCustomers
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
    if 
}

{
    param (
        [Parameter(Mandatory=$true)] 
        [ValidateSet("ExchangeOnline","MgGraph")]
            [String]$Module,
        [Parameter(Mandatory=$true)] [ValidateSet([Customers])] [array]$Client
    )
    if ($Module -eq "ExchangeOnline") {
        $Customer = $Script:Customers | Where-Object {$_.Name -eq "$Client"}
        $message = "Run the following command to connect to Exchange Online as " + $Customer.Name + "`nConnect-ExchangeOnline -DelegatedOrganization " + $Customer.CustomerId
    }elseif ($Module -eq "MgGraph") {
        #Connect-MgGraph -TenantId $CustomerId
        $Customer = $Script:Customers | Where-Object {$_.Name -eq "$Client"}
        $message = "Run the following command to connect to Microsoft Graph as " + $Customer.Name + "`nConnect-MgGraph -ClientId " + $Customer.CustomerId
    }
    Write-Host $message}

Export-ModuleMember -Function Connect-Service, Get-AvailableCustomers