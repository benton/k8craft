#!/usr/bin/env bash
# synchronizes the build output from /build into /data, then runs spigot
set -e

echo "Updating software from /build..."
rsync -va /build/*.jar /build/eula.txt /data/

cd /data
chown mc.mc .
echo "Starting spigot..."
exec sudo -Eu mc \
  java -Xms512M -Xmx${SPIGOT_MAX_RAM} -XX:+UseConcMarkSweepGC -jar spigot.jar
