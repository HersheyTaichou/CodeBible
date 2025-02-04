# Home Assistant, InfluxDB and Grafana

This how-to will take you through setting up Proxmox (PVE) to send logged data to InfluxDB and then access it in Grafana. This will give you access to longer term data logging, statisics and analytics, which allows you to see long term visualizations and trends.

## Prerequisistes

This guide assumes you have Proxmox and Docker already setup.

## Guide

1. Setup InfluxDB in Docker
   1. Under sources, follow "Install InfluxDB using Docker Compose"
   2. Change "DOCKER_INFLUXDB_INIT_ORG" to what you would like your organization name to be.
   3. Change "DOCKER_INFLUXDB_INIT_BUCKET" to "proxmox"
2. Create a bucket to store data in  
   _This is only needed if you do not want to use the bucket automatically created in the previous step or you already have an InfluxDB instance running._
   1. Log into InfluxDB
   2. On the left, go to Load Data > Buckets
   3. On the right, click on Create Bucket
   4. Enter a name and select a retention period  
      _Consider retention periods carefully, as the data and database size can grow quickly, depending on setup._
3. Create an API token for proxmox with write access to the bucket  
   _Best practices is to create a dedicated API token for each service accessing the bucket with restricted permissions_
   1. On the left, go to Load Data > API Tokens
   2. On the right, click on "+ Generate API Token"
   3. Give the token a meaningful description (Proxmox Access)
   4. Under "Buckets" find the bucket you will store Proxmox data in, then check off "Write"
   5. Click "Generate" at the bottom
   6. Copy the API token, once the box is closed, you will not be able to access it again.
4. Send data from Proxmox to InfluxDB
   1. Log into Proxmox with an account that has admin permissions
   2. On the left, go to Datacenter > Metric Server
   3. At the top, click Add > InfluxDB
   4. Add the details for your setup:
      - Name: Name for your InfluxDB server
      - Server: IP of the docker host
      - Port: 8086
      - Protocol: HTTP
      - Organization: Name of the organization in InfluxDB
      - Bucket: This is the bucket created above.
      - Token: This is the token created above
5. Setup Grafana in Docker
   1. Under sources, follow "Run Grafana Docker image"
   2. Change the image to "grafana/grafana-oss" if you do not have an enterprise license
   3. Add the depends on section from the example below (optional)
6. Create an API token for Grafana with read access
   _Best practices is to create a dedicated API token for each service accessing the bucket with restricted permissions_
   1. Go back to InfluxDB
   2. On the left, go to Load Data > API Tokens
   3. On the right, click on + Generate API Token > Custom API Token
   4. Give the token a meaningful description (Grafana)
   5. Under "Buckets" find the bucket you will want to display graph data from, then check off "Read"  
      _Alternatively, check off Read next to "All Buckets"_
   6. Click "Generate" at the bottom
   7. Copy the API token, once the box is closed, you will not be able to access it again.
7. Add InfluxDB to Grafana
   1. Log into Grafana
   2. On the left, go to Connections > Add new connection
   3. Filter by "InfluxDB" and click on it
   4. At the top, change the query language to Flux
   5. Fill in the details for your setup
      - HTTP:
        - URL: http://CONTAINER_NAME:8086
      - Auth: Uncheck all of them
      - InfluxDB Details:
        - Organization: The name of your organization (not the hex ID rom above)
        - Token: The token generated in the previous step
        - Default Bucket: Leave blank to pull all buckets, specify a bucket to read data from
   6. Click "Save & Test" at the bottom to confirm your setup works.

You should now be ready to start building dashboards in Grafana with data from Proxmox.

## Config files

### Docker config.yml

```yaml
services:
  influxdb2:
    container_name: influxdb
    image: influxdb:2
    ports:
      - 8086:8086
    environment:
      DOCKER_INFLUXDB_INIT_MODE: setup
      DOCKER_INFLUXDB_INIT_USERNAME_FILE: /run/secrets/influxdb2-admin-username
      DOCKER_INFLUXDB_INIT_PASSWORD_FILE: /run/secrets/influxdb2-admin-password
      DOCKER_INFLUXDB_INIT_ADMIN_TOKEN_FILE: /run/secrets/influxdb2-admin-token
      DOCKER_INFLUXDB_INIT_ORG: orion_tech
      DOCKER_INFLUXDB_INIT_BUCKET: home_assistant
    secrets:
      - influxdb2-admin-username
      - influxdb2-admin-password
      - influxdb2-admin-token
    volumes:
      - type: volume
        source: influxdb2-data
        target: /var/lib/influxdb2
      - type: volume
        source: influxdb2-config
        target: /etc/influxdb2

  grafana:
    image: grafana/grafana-oss
    container_name: grafana
    restart: unless-stopped
    ports:
      - "3000:3000"
    volumes:
      - grafana-storage:/var/lib/grafana
    depends_on:
      - influxdb2

secrets:
  # these files are in the root account's home folder
  influxdb2-admin-username:
    file: ~/.env.influxdb2-admin-username
  influxdb2-admin-password:
    file: ~/.env.influxdb2-admin-password
  influxdb2-admin-token:
    file: ~/.env.influxdb2-admin-token

volumes:
  influxdb2-data:
  influxdb2-config:
  grafana-storage:
```

## Sources

- [Run Grafana Docker image](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/)
- [Install InfluxDB using Docker Compose](https://docs.influxdata.com/influxdb/v2/install/use-docker-compose/)
