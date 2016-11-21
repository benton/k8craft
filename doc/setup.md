How to Run Spigot Minecraft Server on the Google Cloud Platform
======

Step One -- create a Google Cloud Platform account and an SSH keypair
------
1. [Sign up][1] for a Google Cloud Platform account, then go to the [Cloud Console][2] and create a new Project. Name it anything you like.

2. Decide where you'd like to run your server by choosing a geographic zone from [this list][3].

3. Open a Google Cloud Shell by clicking on its icon in the upper-right, and paste the following text, substituting your desired values for `ZONE` and `DISK_SIZE`:

          export ZONE="us-central1-a"
          export DISK_SIZE="200GB"
          export MACHINE_TYPE="n1-standard-1"
          gcloud compute config-ssh


Step Two -- run the `gcloud-setup.sh` script.
------
1. Paste this into your Google Cloud Shell:
          git clone https://github.com/benton/k8craft
          ./k8craft/gcloud-setup.sh




[1]:https://cloud.google.com/free-trial/
[2]:https://console.cloud.google.com/home/dashboard
[3]:https://cloud.google.com/compute/docs/regions-zones/regions-zones
