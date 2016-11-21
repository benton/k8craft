#!/usr/bin/env bash
# uses the gcloud tool to deploy k8craft
set -e

# check for required variables
export ZONE="us-central1-a"
export DISK_SIZE="200GB"
export MACHINE_TYPE="n1-standard-1"

echo "Creating $DISK_SIZE disk in zone ${ZONE}..."
gcloud compute disks create k8craft-data --size=$DISK_SIZE

echo -n "Creating $MACHINE_TYPE cluster in zone ${ZONE}"
echo " - this will take a couple of minutes..."
gcloud container clusters create k8craft --num-nodes=1 --machine-type=$MACHINE_TYPE

echo -n "Getting Instance ID..."
VM_ID=$(gcloud compute instances list --limit=1 \
  --format="value([name])" --regexp "gke-k8craft-default-pool.*")
echo $VM_ID

echo "Attaching disk $DISK_ID to VM ${VM_ID}..."
gcloud compute instances attach-disk $VM_ID --disk=k8craft-data

echo "Formatting disk..."
gcloud compute ssh --command="sudo mkfs.ext4 /dev/sdb" $VM_ID

echo "Detaching disk $DISK_ID..."
gcloud compute instances detach-disk $VM_ID --disk=k8craft-data

echo "Deploying k8craft..."
kubectl create -f k8-deployment.yaml
kubectl expose deployment k8craft --type="LoadBalancer"

# TODO - wait for availability of IP
IP=$(kubectl describe service | grep "LoadBalancer Ingress" | cut -f 2)

echo "Your Minecraft server IP is: $IP"
echo "Your SSH key is:"
cat .ssh/google_compute_engine
