# Analyzing Windows Crash Dump Logs

## Tools

Install [WinDbg Preview](https://www.microsoft.com/store/productId/9PGJGD53TN86) from the Microsoft Store

## Review

Here is how you can check the logs to see why a computer crashed. If possible, it is best to install the above utility on a separate machine and transfer the file to that machine for analysis

1. Open WinDbg Preview
2. Go to File > Open dump file
3. Browse to and open the dump log
   - Minidumps are stored at "C:\Windows\Minidump" by default
   - The full log is stored at "C:\Windows\memory.dmp" by default
4. Wait for the debugger to load the file, then click on `!analyze -v`
5. Review the output to determine what caused the crash

At the top, you should see the basic details that may have been displayed to the user

```text
*******************************************************************************  
*                                                                             *  
*                         Bugcheck Analysis                                   *  
*                                                                             *  
*******************************************************************************  

DRIVER_IRQL_NOT_LESS_OR_EQUAL (d1)  
An attempt was made to access a pageable (or completely invalid) address at an  
interrupt request level (IRQL) that is too high.  This is usually  
caused by drivers using improper addresses.  
If kernel debugger is available get stack backtrace.  
Arguments:  
Arg1: 000000cdd557f170, memory referenced  
Arg2: 0000000000000002, IRQL  
Arg3: 0000000000000000, value 0 = read operation, 1 = write operation  
Arg4: fffff807c2531ae1, address which referenced memory  
```

If you scroll down, you should find a section on the module that failed, it may look like this:

```text
YMBOL_NAME:  rassstp!RetrieveSendPackets+8d

MODULE_NAME: rassstp

IMAGE_NAME:  rassstp.sys

IMAGE_VERSION:  10.0.19041.3205

STACK_COMMAND:  .cxr; .ecxr ; kb

BUCKET_ID_FUNC_OFFSET:  8d

FAILURE_BUCKET_ID:  AV_rassstp!RetrieveSendPackets

OSPLATFORM_TYPE:  x64

OSNAME:  Windows 10

FAILURE_ID_HASH:  {cc96ef30-062c-2493-447f-a365f71c1c23}

Followup:     MachineOwner
```

In the above example, the `rassstp` module failed. Research should be done on the failing module, and may require updated drivers or a repair of Windows. See [Repair Windows](Repair.md) for steps.
