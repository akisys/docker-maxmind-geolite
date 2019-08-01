# docker-maxmind-geolite

- auto-updating container for MaxMind GeoLite2 Databases
- using MaxMind `geoipupdate` software
- using customizable cron timer

## Usage

- databases are downloaded into the GeoIP.conf default path under
  `/usr/local/share/GeoIP`
- this path is exposed as Docker volume and can be re-used in other containers

## Note

All established licenses remain unchanged and can be found inside the container
under the path `/geoipupdate/`.

