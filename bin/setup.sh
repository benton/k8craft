#!/usr/bin/env bash
# uses the gcloud tool to deploy k8craft
set -ue

if [ -z ${DISK_SIZE+x} ]; then
  echo "ERROR: DISK_SIZE is unset!" && exit 1
fi
if [ -z ${MACHINE_TYPE+x} ]; then
  echo "ERROR: MACHINE_TYPE is unset!" && exit 1
fi

abs_path() { # Returns the absolute path of this script regardless of symlinks
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )"
} # From: http://stackoverflow.com/a/246128

echo "Creating $DISK_SIZE disk..."
gcloud compute disks create k8craft-data --size=$DISK_SIZE

echo -n "Creating $MACHINE_TYPE cluster"
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
#gcloud container clusters get-credentials k8craft
K8C_HOME=$(cd `abs_path`/.. && pwd)
kubectl create -f "${K8C_HOME}/k8-deployment.yaml"
kubectl expose deployment k8craft --type="LoadBalancer"

# TODO - wait for availability of IP
IP=$(kubectl describe service k8craft | grep "LoadBalancer Ingress" | cut -f 2)

echo "===================================================="
echo "Your SSH key is:"
echo "===================================================="
cat .ssh/google_compute_engine
echo "===================================================="
echo "Your Minecraft server IP is: $IP"
echo "===================================================="
