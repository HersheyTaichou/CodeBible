# Unifi Network

By default, the Unifi Network application is restricted to Mongo BD version 3.6 and below. As version 3.6 is EOL, this can be a security risk.

The solution is to install a newer version of Mongo DB, then manually install Unifi and bypass the max version restriction.

I DO NOT RECOMMEND doing this in a production environment, as it is not supported by UniFi

1. First, deploy a fresh copy of Debian
2. Install a supported version of MongoDB
   - I've tried the following
     - [MongoDB 4.4](https://www.mongodb.com/docs/v4.4/tutorial/install-mongodb-on-debian/) with Unifi network version 7.4 on Debian 10
     - [MongoDB 7.0](https://www.mongodb.com/docs/v7.0/tutorial/install-mongodb-on-debian/) with Unifi network version 7.5 on Debian 11
3. Download the latest version of Unifi Network to the Debian host
   - [Unifi Download Page](https://www.ui.com/download)
4. Install it with the following command

   ```bash
   dpkg --ignore-depends=mongodb-org-server -i unifi_sysvinit_all.deb
   ```

5. Edit the UniFi package requirements
   1. Edit the following file

      ```bash
      nano /var/lib/dpkg/status
      ```

   2. Find these lines

      ```text
      Package: unifi
      Status: install ok installed
      ```

   3. Remove the maximum versions from the Depends line, so it looks like this

      ```text
      Depends: binutils, coreutils, adduser, libcap2, curl, mongodb-server (>= 2.4.10) | mongodb-10gen (>= 2.4.14) | mongodb-org-server (>= 2.6.0), mongodb-server | mongodb-10gen | mongodb-org-server, java8-runtime-headless, jsvc (>= 1.0.8), logrotate
      ```

6. Open the Unifi portal. You should be able to set it up or restore from backup without issue now

Source: <https://www.scheh.com/index.php/2020/10/20/use-unifi-with-mongodb-above-4-0-0/>
