# Chocolatey

A package manager for Windows. You can find more information at their site, [Chocolately.org](https://chocolatey.org)

## How to Install

Chocolatey provides different install steps for different needs. You can find the various methods on [the Chocolatey install page](https://chocolatey.org/install)

## How to Configure

Chocolatey should not require any special configuration for most use, but it is possible to host internal package repositories or change where packages are installed. More information can be found in the [Chocolatey Docs](https://docs.chocolatey.org/)

## How to Use

Once installed, you can browse the [package database](https://community.chocolatey.org/packages) to look for any software you need installed

### How to Install Packages

All packages will need to be installed from an elevated PowerShell prompt. They are installed with the following command:

```PowerShell
choco install packagename
```

You can specify multiple package names, for instance, to set up a newly installed machine with all needed software. You can also add -y at the end to have it install the packages without prompting.

### How to Upgrade Packages

There are two ways to upgrade. You can either upgrade just one package, or you can upgrade all the packages managed by Chocolatey

To upgrade one package, run the following command passing one or more package names to upgrade

```PowerShell
choco upgrade packagename
```

To upgrade all the packages managed by Chocolatey, pass the "all" special package keyword

```PowerShell
choco upgrade all
```

When run with the "all" special package keyword, it will check for updates to any installed packages and only upgrade the packages with available upgrades

### How to Uninstall Packages

Chocolatey can attempt to uninstall any software that was installed by it. Uninstalling software is done with the following command:

```PowerShell
choco uninstall packagename
```

This can also take the "all" special package keyword to remove all managed software
