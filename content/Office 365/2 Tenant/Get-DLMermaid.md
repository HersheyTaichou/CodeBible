---
title: Distribution Lists as Mermaid Chart
description: Visualize nested distribution lists as a mermaid chart
---

# Get-DLMermaid

## SYNOPSIS
Visualize nested distribution lists as a mermaid chart

## DESCRIPTION
This script will output a Mermaid file that can be used to visualize how distribution groups are nested within each other.

## Parameters

### TopDistributionList

This is the distribution list you want to start with, at the top of the nesting

### Path

This is where you want to save the mermaid file

### Levels

The maximum number of levels to traverse

### IncludeUsers

Enable to show users (not just nested DLs) in the output

## Examples

## Notes

### Convert to PNG

Once the above file is generated, it has to be converted to a PNG file. This can be done with [mermaid-js/mermaid-cli: Command line tool for the Mermaid library](https://github.com/mermaid-js/mermaid-cli)

These steps are written on a Linux machine

1. First install [Nodesource](https://nodesource.com)
2. Then install mermaid-cli

   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

3. Create `.puppeteerrc.cjs` with the following content

   ```json
   /**
   * @type {import("puppeteer").Configuration}
   */
   module.exports = {
     // Download Chrome (default `skipDownload: false`).
     "chrome-headless-shell": {
       skipDownload: false,
       version: "131.0.6778.204",
     },
   };
   ```

4. Then install the browser: `sudo npx puppeteer browsers install`

You are now ready to convert the output files to png!

1. Create a config file (needed for very large mmd files)
   - mmdconfig.json
     ```json
     {
       "maxTextSize": 90000,
       "flowchart": {
         "useMaxWidth": false,
         "htmlLabels": true
       }
     }
     ```

2. Then the file can be generated with the following command:
   ```bash
   mmdc -i File.mmd -o File.png -c mmdconfig.json
   ```

