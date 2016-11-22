#!/usr/bin/env bash
# uses the kubectl tool connect to the server console
set -ue

echo "Fecthing pod name..."
POD=$(kubectl get pods -l app=k8craft -o=custom-columns=NAME:.metadata.name | tail -1)

echo "Connecting to container 'mc' within pod ${POD}..."
echo "   use \"restart\" to restart the server, or PRESS CTRL-D to disconnect..."
exec kubectl attach -i -t -c mc $POD
