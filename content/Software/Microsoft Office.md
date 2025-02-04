# Microsoft Office

## How to Install

For just one machine with one user, you can log in to [Portal.Office.com](https://portal.office.com) and click the "Install Apps" button in the top right corner.

### Microsoft Office Deployment Tool

When installing on multiple machines or on a shared computer (Such as a remote desktop host), you want to use the Office Deployment Tool

Download the latest version of the [deployment tool](https://www.microsoft.com/en-us/download/details.aspx?id=49117)

Go to the [Office Config Website](https://config.office.com) to set up a custom XML file for use when installing Office. It includes a variety of options, including which software to install, and if it will be used in a shared environment.

From an elevated terminal, go to the folder where you saved the setup.exe file and downloaded the XML file.

This command will download all the files needed to install Office. This step is useful in the following circumstances but is otherwise optional.

- When the machine getting Office will not have internet access
- When installing Office on multiple machines, and you want to reduce the bandwidth usage
- When installing Office on a machine with a limited internet connection

```PowerShell
Setup.exe /download Configurationfile.xml
```

This will initiate the installation of Office on the computer per your specifications, drawing from the XML file details for the version of Office, patching level, and update channel.

```PowerShell
Setup.exe /configure Configurationfile.xml
```

## How to Configure

Once it is installed, make sure to open Outlook and sign in to register the software, and link it to your mailbox

## How to Use

### Change the Office 365 Channel

1. Launch a terminal as an administrator.
2. Navigate to “C:\Program Files\Common Files\Microsoft Shared\ClickToRun\”
3. Run the following commands

   ```bat
   .\OfficeC2RClient.exe /changesetting Channel=<Channel keyword>
   .\OfficeC2RClient.exe /update user
   ```

### Check the version of Office Installed

```PowerShell
Get-WmiObject win32_product | where{$_.Name -like "*Office*"} | select Name,Version
```

| Channel                        | Keyword in CMD or ODT                                |
| ------------------------------ | ---------------------------------------------------- |
| Monthly Channel (Targeted)     | Channel=”Insiders” or Channel=”FirstReleaseCurrent“  |
| Monthly Channel                | Channel=”Monthly” or Channel=”Current“               |
| Semi-annual Channel (Targeted) | Channel=”Targeted” or Channel=”FirstReleaseDeferred“ |
| Semi-annual Channel            | Channel=”Broad” or Channel=”Deferred“                |

#### Source

<https://erwinbierens.com/switch-office-2016-to-monthly-targeted-channel/>
