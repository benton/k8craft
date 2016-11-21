How to Run Spigot Minecraft Server on the Google Cloud Platform
======

1. [Sign up][1] for a Google Cloud Platform account, then go to the [Cloud Console][2] and create a new Project. Name it anything you like.

2. Choose a geographic zone from [this list][3] where your server will run. Then open a Google Cloud Shell by clicking on its icon in the upper-right, and enter the following text. Make sure you change `us-central1-a` to your desired zone:

        gcloud config set compute/zone us-central1-a

3. Create an SSH keypair for your server by pasting in the following:

        gcloud compute config-ssh

    You'll need the secret key created in this step to manage the plugins directory, logs and generally anything in the server's working Minecraft directory. Print out the key with the following command and save it somewhere on your workstation.

        cat ~/.ssh/google_compute_engine

3. Paste this into your Google Cloud Shell, substituting your desired value for `DISK_SIZE`:

        export DISK_SIZE="200GB"
        export MACHINE_TYPE="n1-standard-1"
        git clone https://github.com/benton/k8craft.git
        ./k8craft/bin/setup.sh

[1]:https://cloud.google.com/free-trial/
[2]:https://console.cloud.google.com/home/dashboard
[3]:https://cloud.google.com/compute/images/zones_diagram.svg
