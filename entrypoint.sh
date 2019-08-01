#!/bin/sh

set -e

echo "### On-Start GeoLite2 DB update"
/usr/local/bin/geoipupdate -v > /proc/1/fd/1 2>/proc/1/fd/2

echo "### On-Start GeoLite2 DB cron job setup"
echo "$CRONTIMER /usr/local/bin/geoipupdate -v > /proc/1/fd/1 2>/proc/1/fd/2" | crontab
crontab -l

echo "### Starting cron in foreground"
cron -f
