# Bulk resolve MX records from a CSV

$CompanyDomains = Import-Csv Customers_20230818T1647Z.csv
$Output = @()

foreach ($Entry in $CompanyDomains) {
    $MXRecords = Resolve-DnsName -Name $Entry.Domain -Type MX
    $RecordScring = ""
    foreach ($Record in $MXRecords) {
        $RecordScring += $Record.NameExchange + "," + $Record.Preference + ";"
    }
    $Properties = [ordered]@{
        "Company" = $Entry.Customer
        "Domain" = $Entry.Domain
        "MXRecord" = $RecordScring
    }
    $Output += New-Object -TypeName PSObject -Property $Properties
}

$Output | Export-Csv Customers-MXRecords.csv
