---
title: Windows 11 and Office 365 Deployment Lab Kit
description: Microsoft provides an easy-to-setup pre-configured home lab with several VMs
---

<<<<<<< HEAD
=======

>>>>>>> cd254695d0bd20b8bfd31deaa5fcade1be7e86fa
The lab contains evaluation versions of the following products:

- Windows 11 Enterprise, Version 24H2
- Microsoft Configuration Manager, Version 2409
- Windows Server 2022

It is designed to be deployed to an existing Hyper-V instance on the currently running machine.

The software and guides can be downloaded here:

[Windows 11 and Office 365 Deployment Lab Kit](https://www.microsoft.com/en-us/evalcenter/evaluate-lab-kit)

## Hyper-V Setup

The download site includes a set of Lab Guides. Included in the guides is a "Set Up Guide" that details the steps needed to configure Hyper-V and extract the VMs.

## Proxmox Setup

> [!Update] These steps were written for the previous version of the lab, built on Windows 10. Some adjustments may be required.

1. Download and extract the Zip file from Microsoft
1. Use the setup guide to add the VMs to Hyper-V on the local machine
1. Create VMs in Proxmox
   - General
     - Set the name and other details following your standards
   - OS
     - Do not use any media
     - Type: Microsoft Windows
     - Version: 10/2016/2019
   - System
     - Graphics card: Default
     - Machine: Default
     - BIOS: OVMF (UEFI)
     - Add EFI Disk: True
     - SCSI Controller: Default
     - Qemu Agent: Set following your standards
     - Add TPM: True
     - TPM Storage: Set following your standards
     - Version: v2.0
   - Disks
     - Do not create a disk (We will import one later)
   - CPU
     - Sockets: 1
     - Cores: 2
     - Type: Default
   - Memory
     - Set this to at least 2048, 4096 is recommended
   - Network
     - Set this according to your setup, but it should be separate from production servers. VyOS is a lightweight router OS that can be used to create a dedicated separate network on a VM host
1. Remove Snapshots
   1. Open the Hyper-V manager
   2. Shutdown any running VMs
   3. Select the VM you plan to move to Proxmox
   4. Right-click on the Base snapshot and remove it
   5. Wait for the merge to complete
1. Convert the drives from VHDX to VHD

   1. Open PowerShell as an admin
   2. Browse to the VM folder, then into the Virtual Hard Disks folder
   3. Run this command, substituting the drive names for the VM you are converting

      ```PowerShell
      Convert-VHD -Path .\HYD-DC1.VHDX -DestinationPath .\HYD-DC1.vhd -VHDType Dynamic
      ```

1. Add the drives to the created VMs

   1. Move the converted disk files to a location accessible to Proxmox
      - A network share accessible to Proxmox is easiest, otherwise, the server will need enough space for the VHDX file and the imported drive
   2. Import the VHDX file and assign it to the VM

      ```bash
      qm importdisk 102 image.vhd local-zfs
      ```

   3. Mount it in the VM
      1. Open the VM's Hardware page
      2. Select the unused disk
      3. Click Edit
      4. Click Add
      5. Switch to the Options page
      6. Click on Boot Order
      7. Check off the imported drive, and move it to the top

1. Boot the VM

#Test_env
