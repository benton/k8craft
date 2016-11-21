#!/usr/bin/env bash
# uses the gcloud tool to tear down the service and cluster
set -ue

echo "Deleting service..."
kubectl delete deployment,service k8craft

echo "Deleting cluster..."
gcloud container clusters delete k8craft

echo "Deleting data..."
gcloud compute disks delete k8craft-data
