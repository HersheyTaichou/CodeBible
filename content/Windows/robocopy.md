# Robocopy - A powerful file copy tool

Robocopy runs in PowerShell or CMD and can copy files between two accessible locations. It has granular settings for the existing file permissions

## Usage

This is the basic format for the command:

```bat
robocopy <source> <destination>  [<options>]
```

## Examples

### Example One

```bat
Robocopy SOURCE DESTINATION /copyall /r:0 /w:0 /e /log:logfile.txt
```

- Copy `SOURCE` to `DESTINATION`
- `/copyall` - Copy all the permissions
- `/r:0` - Start the next run time as soon as possible
- `/w:0` - Retry as soon as possible
- `/e` - Copy subdirectories, including empty ones
- `/log:logfile.txt` - save the log to logfile.txt

### Example Two

```bat
robocopy <Source> <Destination> /s
```

- Copy `SOURCE` to `DESTINATION`
- `/s` - Copyu subdirectories, but skip any empty directories

## Documentation

[RoboCopy](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy)
