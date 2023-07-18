# AD Replication

## Replicate this server with all of it's replication partners

```bat
repadmin /syncall /AedP
```

## Replicate all DCs with all of their replication partners

```PowerShell
(Get-ADDomainController -Filter *).Name | Foreach-Object {repadmin /syncall $_ (Get-ADDomain).DistinguishedName /AdeP}
```
