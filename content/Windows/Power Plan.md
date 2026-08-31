# Windows Power Plan

## View the current power plan

Run this command to see all of the available power plans

```bat
Powercfg -l
```

The output should look like this:

```text
Existing Power Schemes (* Active)
-----------------------------------
Power Scheme GUID: 381b4222-f694-41f0-9685-ff5bb260df2e  (Balanced) *
Power Scheme GUID: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c  (High performance)
Power Scheme GUID: a1841308-3541-4fab-bc81-f71556f20b4a  (Power saver)
```

## Change the active Power Plan

Run the following command to change the current power plan

```bat
Powercfg -s {guid}
```

You will need to substitute `{guid}` for the GUID of the desired power plan. See the first command to get the GUID

### Example

Run the following to set the Balanced power plan as active

```bat
Powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e
```
