#!/usr/bin/env bash
# uses the kubectl tool to get the server log
set -ue

# echo "Fecthing pod name..."
POD=$(kubectl get pods -l app=k8craft -o=custom-columns=NAME:.metadata.name | tail -1)

# echo "Fecthing logs from container 'mc' within pod ${POD}..."
exec kubectl logs "$@" -c mc $POD
