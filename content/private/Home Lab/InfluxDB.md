# Installing and Setting Up InfluxDB

## Install in Docker Compose

This is the docker-compose file I created

```yaml
  influxdb:
    image: influxdb:2.7.0
    container_name: influxdb
    restart: unless-stopped
    ports:
     - 8086:8086
    volumes:
     - influxdb_data:/var/lib/influxdb2

volumes:
  influxdb_data: {}
```

You can connect to it at <http://DockerIP:8086>. Go through the initial setup.

## Setup in Home Assistant

If you are using different buckets for different data, create a bucket for Home Assistant.

### Setup the InfluxDB credentials

1. In InfluxDB, go to the arrow pointing up on the left, then click on API Tokens.
2. Click on Generate API Token and click on Custom Access Token
3. Check off Write access for the bucket you will store HA info in
   - Also click on Read, for any buckets you want HA sensors for
4. Click on Generate at the bottom
5. Copy the key. It will only be shown this one time!

### Setup Home Assistant

1. Open `Configuration.yaml` in Home Assistant
2. Add a section for InfluxDB. Information on available settings can be found on [Home Assistant's Website](https://www.home-assistant.io/integrations/influxdb/)

   ```yaml
   influxdb:
    api_version: 2
    ssl: false
    host: 192.168.1.100
    port: 8086
    token: GENERATED_AUTH_TOKEN
    organization: RANDOM_16_DIGIT_HEX_ID
    bucket: BUCKET_NAME
    tags:
        source: haos
    tags_attributes:
        - friendly_name
    default_measurement: units
   ```

3. Go to Developer Tools and click on Check Configuration
4. If everything worked, click on Restart > Restart Home Assistant
5. Check data is showing up in InfluxDB
   1. On the left, go to Data Explorer
   2. Select the bucket HA data is stored in
   3. Select the units measurement
   4. Confirm entities from HA show up under Tag Keys

## Setup in Grafana
