# Ensures you have the partner center module already, and if not, try to install it.
try {
    Import-Module PartnerCenter
}
catch {
    Install-Module PartnerCenter
    Import-Module PartnerCenter
}

<#
.SYNOPSIS
Load and store an array with all the current customers

.DESCRIPTION
This function will retrieve a list of all the current customers, either by 
loading it from a file or by logging into the partner center. 

It will force a refresh of the local file every 6 months, or on demand with 
the below parameters

.PARAMETER CustomerList
You can use this to specify a location to save the file, if you do not want 
to use the default

.PARAMETER UpdateFile
This will force the command to update the file 

.EXAMPLE
Get-AvailableCustomers

AllowDelegatedAccess  : 
AssociatedPartnerId   : 
BillingProfile        : 
CommerceId            : 
CustomerId            : 12345678-9abc-def-1234-56789abcdef1
Domain                : contoso.onmicrosoft.com
Name                  : Contoso Ltd.
RelationshipToPartner : Reseller

AllowDelegatedAccess  : 
AssociatedPartnerId   : 
BillingProfile        : 
CommerceId            : 
CustomerId            : 12345678-9abc-def-1234-56789abcdef1
Domain                : example.onmicrosoft.com
Name                  : The Example Company
RelationshipToPartner : Reseller

.NOTES
General notes
#>
function Get-AvailableCustomers {
    [CmdletBinding()]
    param (
        [Parameter()][String]$CustomerList = "$env:appdata\Azure\customers.json",
        [Parameter()][bool]$UpdateFile = $false
    )

    If ((Test-Path $CustomerList) -and (Get-ChildItem $CustomerList | Where-Object {$_.LastWriteTime -ge (Get-Date).AddMonths(-6) -and -not($UpdateFile) } )){
        $Customers = Get-Content -Raw $CustomerList | Convertfrom-Json
    } else {
        Write-Host "Please log into the Partner Center"
        Connect-PartnerCenter
        $Customers = Get-PartnerCustomer
        New-Item -ItemType Directory $env:appdata\Azure
        $Customers | ConvertTo-Json | Out-File $CustomerList -Force
    }
    return $Customers
}

<#
.SYNOPSIS
Get the Customer details for a specific customer

.DESCRIPTION
This will use Get-AvailableCustomers then filter the result to return only one
customer. This is useful if you need to check what a companies domain or 
customer ID is, but do not want to connect. 

.PARAMETER Customer
This is the string to seach for a customer. It should be part of the 
customer's name or domain to return results

.EXAMPLE
Get-CustomerDetails -Customer "Example"

AllowDelegatedAccess  : 
AssociatedPartnerId   : 
BillingProfile        : 
CommerceId            : 
CustomerId            : 12345678-9abc-def-1234-56789abcdef1
Domain                : example.onmicrosoft.com
Name                  : The Example Company
RelationshipToPartner : Reseller

.NOTES
General notes
#>
Function Get-CustomerDetails {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string] $Customer
    )
    $details = Get-AvailableCustomers | Where-Object {$_.Name -like "*$Customer*" -or $_.Domain -like "*$Customer*"}
    return $details
}

<#
.SYNOPSIS
Provides the command to log in to a tenant with partner credentials

.DESCRIPTION
This function will provide you with the command needed to log into a customer's 
specific tenant account, with the specificed module, using your partner 
credentials

.PARAMETER Module
One of the PowerShell tenant modules, AzureAD, ExchangeOnline or MgGraph

.PARAMETER Customer
The customer you want to connect with. It searches for this string as part of 
the name or domain. You can validate the string with Get-CustomerDetails

.EXAMPLE
Connect-PartnerService -Module MgGraph -Customer Contoso

"Run the following command to connect to Microsoft Graph as Contoso Ltd.
Connect-MgGraph -TenantId 12345678-9abc-def-1234-56789abcdef1

.EXAMPLE
Connect-PartnerService -Module ExchangeOnline -Customer Contoso

"Run the following command to connect to Exchange Online as Contoso Ltd.
Connect-ExchangeOnline -DelegatedOrganization 12345678-9abc-def-1234-56789abcdef1

.NOTES
General notes
#>
function Connect-PartnerService {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)] 
        [ValidateSet("AzureAD","ExchangeOnline","MgGraph")]
            [String]$Module,
        [Parameter(Mandatory=$true)] [string]$Customer
    )
    $CustomerDetails = Get-CustomerDetails -Customer $Customer
    Write-Verbose $CustomerDetails
    if (-not($null -eq $CustomerDetails) -and $Module -eq "AzureAD") {
        $message = "Run the following command to connect to Azure AD as " + $CustomerDetails.Name + "`nConnect-AzureAD -TenantId " + $CustomerDetails.CustomerId
        #$session = Connect-AzureAD -TenantId $CustomerDetails.CustomerId
    } elseif (-not($null -eq $CustomerDetails) -and $Module -eq "ExchangeOnline") {
        $message = "Run the following command to connect to Exchange Online as " + $CustomerDetails.Name + "`nConnect-ExchangeOnline -DelegatedOrganization " + $CustomerDetails.CustomerId
        #$session = Connect-ExchangeOnline -DelegatedOrganization $CustomerDetails.CustomerId
    } elseif (-not($null -eq $CustomerDetails) -and $Module -eq "MgGraph") {
        $message = "Run the following command to connect to Microsoft Graph as " + $CustomerDetails.Name + "`nConnect-MgGraph -TenantId " + $CustomerDetails.CustomerId
        #$session = Connect-MgGraph -TenantId $CustomerDetails.CustomerId
    } else {
        $Message = "The customer was not found in the list of partner customers. Please check the customer name or domain, and review the list of customers with Get-AvailableCustomers"
    }
    return $message
    #return $session
}

Export-ModuleMember -Function Get-AvailableCustomers, Get-CustomerDetails, Connect-PartnerService