#!/usr/bin/env bash
# builds all images
set -e

echo "Building Spigot JARs into ./pkg..."
docker-compose run spigot-build

echo "Building Spigot Docker image..."
docker-compose build spigot

echo "Building SSH Docker image..."
docker-compose build ssh
