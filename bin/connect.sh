#!/usr/bin/env bash
# uses the kubectl tool connect to the server console
set -ue

echo "Fecthing pod name..."
POD=$(kubectl get pods -l app=k8craft -o=custom-columns=NAME:.metadata.name | tail -1)

echo "Connecting to container 'spigot' within pod ${POD}..."
echo "   PRESS CTRL-D to disconnect..."
exec kubectl attach -i -t -c spigot $POD
