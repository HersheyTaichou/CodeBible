---
title: Proxmox VE
description: Proxmox VE is a hypervisor based on Debian Linux
---

Proxmox VE is a hypervisor based on Debian Linux

## Install

Proxmox Community Edition can be downloaded for free from [their website](https://www.proxmox.com/en/)

## Config locations

The location of the VM config files is:

```bash
cd /etc/pve/qemu-server/
```

The location of the container config files is:

```bash
cd /etc/pve/lxc/
```

## Troubleshooting

### Networking issues

I ran into issues with the networking card in my host system, which is a "Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)"

It would default to the r8169 module, and every time a VM would use a significant portion of the bandwidth, the networking would stop working. The resolution was to install the r8168-dkms package to switch to the r8168 module, then reboot.

```bash
apt install r8168-dkms
```

#Hypervisor #Test_env
