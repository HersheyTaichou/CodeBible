---
title: Unifi Network
---

## UniFi Network 7.5 and Newer

- UniFi Network Application 7.5 and newer requires MongoDB 3.6 and Java 17.
- Version 7.5 to 8.0 supports up to MongoDB 4.4.
- Version 8.1 and newer supports up to MongoDB 7.0.
- Version 9.0 and newer supports up to MongoDB 8.0 and Java 17/21.

When doing a fresh install, you can go straight to the newest version of MongoDB supported by that version of Unifi network.

If you are doing an upgrade, you will need to follow the process documented in the MongoDB release notes to step up the database to the latest version.

> [!UpgradePath] 3.6 --> 4.0 --> 4.2 --> 4.4 --> 5.0 --> 6.0 --> 7.0

- [Upgrade 3.6 to 4.0](https://www.mongodb.com/docs/legacy/) - This is only available as a download archive
- [Upgrade 4.0 to 4.2](https://www.mongodb.com/docs/v4.4/release-notes/4.2-upgrade-standalone/)
- [Upgrade 4.2 to 4.4](https://www.mongodb.com/docs/v4.4/release-notes/4.4-upgrade-standalone/)
- [Upgrade 4.4 to 5.0](https://www.mongodb.com/docs/manual/release-notes/5.0-upgrade-standalone/)
- [Upgrade 5.0 to 6.0](https://www.mongodb.com/docs/manual/release-notes/6.0-upgrade-standalone/)
- [Upgrade 6.0 to 7.0](https://www.mongodb.com/docs/manual/release-notes/7.0-upgrade-standalone/)

Source: [Upgrade path for MongoDB now that UniFi 8.1.113 supports MongoDB up to 7.0 (don't blindly jump major MongoDB versions) : r/Ubiquiti](https://www.reddit.com/r/Ubiquiti/comments/1bjlbmf/upgrade_path_for_mongodb_now_that_unifi_81113/)

## UniFi Network v7.4 or Prior

By default, the Unifi Network application is restricted to MongoDB version 3.6 and below. As version 3.6 is EOL, this can be a security risk.

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
