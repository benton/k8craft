#!/usr/bin/env bash
# synchronizes the build output from /build into /data, then runs spigot
set -e

echo "Updating software from /build..."
rsync -va /build/*.jar /build/eula.txt /data/

cd /data
chown mc.mc .
echo "Starting spigot..."
exec setuser mc \
  java -Xms512M -Xmx${MAX_RAM} -XX:+UseConcMarkSweepGC -jar ${SERVER_JAR}.jar
