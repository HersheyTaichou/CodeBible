---
title: Reset the TCP/IP Stack
---

Run the following commands in an elevated CMD or PowerShell prompt to Reset the TCP/IP Stack

```bat
netsh advfirewall reset
netsh branchcache reset
netsh int ip reset
netsh int ipv6 reset
netsh winsock reset
netsh winsock reset catalog
netsh int ip reset reset.log
```

#Networking
