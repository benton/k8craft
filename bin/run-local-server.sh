#!/usr/bin/env bash
# runs the Spigot server on localhost port 25565
# data is stored in ./data
set -e

docker-compose up spigot
