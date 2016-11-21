#!/usr/bin/env bash
# uses the gcloud tool to set up and deploy k8craft
set -ue

# check for required variables
if [ -z ${DISK_SIZE+x} ]; then
  echo "ERROR: DISK_SIZE is unset!" && exit 1
fi
if [ -z ${MACHINE_TYPE+x} ]; then
  echo "ERROR: MACHINE_TYPE is unset!" && exit 1
fi

echo "Creating $DISK_SIZE disk..."
gcloud compute disks create k8craft-data --size=$DISK_SIZE

echo -n "Creating $MACHINE_TYPE cluster - this will take a couple of minutes..."
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
exec $K8C_HOME/bin/deploy.rb
