# Windows Time Settings

## Set the PDC Time

1. First, locate your PDC Server. Open the command prompt and type:

    ```bat
    netdom /query fsmo
    ```

2. Log in to your PDC Server and open the command prompt.
    1. Check if the PDC is a HyperV VM
    2. If it is, log into the host
    3. Right-click on the VM and open the properties
    4. On the left, go down to the services and turn off the time sync service
    5. Return to the PDC and continue
3. Stop the W32Time service:

    ```bat
    net stop w32time
    ```

4. Configure the external time sources

    ```bat
    w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org” /update
    ```

5. Make your PDC a reliable time source for the clients.

    ```bat
    w32tm /config /reliable:yes
    ```

6. Start the w32time service:

    ```bat
    net start w32time
    ```

7. The Windows time service should begin synchronizing the time. You can check the external NTP servers in the time configuration by typing:

    ```bat
    w32tm /query /configuration
    ```

## Fix the time source on a domain member

1. Check the current settings

    ```bat
    w32tm /query /status
    ```

    Most likely, it will return something similar to the following, pay attention to the source.

    ```text
    Leap Indicator: 3(not synchronized)
    Stratum: 0 (unspecified)
    Precision: -23 (119.209ns per tick)
    Root Delay: 0.0000000s
    Root Dispersion: 0.0000000s
    ReferenceId: 0x00000000 (unspecified)
    Last Successful Sync Time: unspecified
    Source: Local CMOS Clock
    Poll Interval: 10 (1024s)
    ```

2. Restart the time service

    ```bat
    net stop w32time
    net start w32time
    ```

3. Update the settings

    ```bat
    w32tm /config /update
    ```

4. Sync settings from the domain

    ```bat
    w32tm /resync /rediscover
    ```

5. Confirm it is querying the domain now

    ```bat
    w32tm /query /status
    ```

    It should return something similar to the following, note the updated source.

    ```text
    Leap Indicator: 0(no warning)
    Stratum: 4 (secondary reference - syncd by (S)NTP)
    Precision: -23 (119.209ns per tick)
    Root Delay: 0.0475434s
    Root Dispersion: 14.8991085s
    ReferenceId: 0xC0A803E3 (source IP:  192.168.3.227)
    Last Successful Sync Time: 7/15/2019 1:21:37 PM
    Source: DC1.domain.local
    Poll Interval: 10 (1024s)
    ```
