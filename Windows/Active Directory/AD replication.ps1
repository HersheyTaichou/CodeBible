# Replicate this server with all of it's replication partners
repadmin /syncall /AedP

# Replicate all DCs with all of their replication partners
(Get-ADDomainController -Filter *).Name | Foreach-Object {repadmin /syncall $_ (Get-ADDomain).DistinguishedName /AdeP}
