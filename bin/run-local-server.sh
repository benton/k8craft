#!/usr/bin/env bash
# Uses docker to run a server on localhost port 25565
# data is stored in k8craft/data/
set -e

abs_path() { # Returns the absolute path of this script regardless of symlinks
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )"
} # From: http://stackoverflow.com/a/246128
K8C_HOME=$(cd `abs_path`/.. && pwd)

echo "Running local minecraft server with data in ${K8C_HOME}/data/..."
docker-compose up mc
