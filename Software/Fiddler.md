# Telerik Fiddler

Fiddler is a Web debugging proxy to view and analyze network traffic on the local machine.

## How to Install

Fiddler can be downloaded from the [Telerik site](https://www.telerik.com/fiddler)

It can also be installed with Chocolatey

```PowerShell
choco install fiddler
```

## How to Configure

It typically requires very little configuration out of the box, but if you are working with a modern Windows app, you will need to click the WinConfig button in the top left corner, then check off the app in question.

## How to Use

### Analyze HTTPS Traffic

To view and analyze HTTPS traffic, you need to add some certificates to the local machine and permit Fiddler to decrypt the traffic, and then re-encrypt it with its certificate, before serving the traffic to the active program

1. Click on Tools at the top
2. Go to Telerik Fiddler Options
3. Switch to the HTTPS tab
4. Toggle the options to capture HTTPS CONNECTs and Decrypt HTTPS traffic
5. Click Yes through the prompts
6. When done, make sure to remove the Fiddler certificate from the Computer certificate store
