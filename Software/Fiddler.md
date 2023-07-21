# Telerik Fiddler

Fiddler is a utility to view and analyze network traffic on the local machine

## HTTPS Traffic

To view and analyze HTTPS traffic, you need to add some certificates to the local machine and give Fiddler permission to decrypt the traffic and then re-encrypt it with its certificate, before serving the traffic to the active program

1. Click on Tools at the top
2. Go to Telerik Fiddler Options
3. Switch to the HTTPS tab
4. Toggle the options to capture HTTPS CONNECTs and Decrypt HTTPS traffic
5. Click Yes through the prompts
6. When done, make sure to remove the Fiddler certificate from the Computer certificate store

## Website

<https://www.telerik.com/fiddler>
