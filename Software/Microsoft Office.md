# Microsoft Office Deployment Tool

Download the latest version of the deployment tool  
<https://www.microsoft.com/en-us/download/details.aspx?id=49117>

Go to the [Office Config Website](https://config.office.com) to set up a custom XML file for use when installing Office.  It includes a variety of options, including which software to install, and if it will be used in a shared environment.

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
