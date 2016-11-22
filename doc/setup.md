How to Run a Minecraft Server on the Google Cloud Platform
======

1. [Sign up][1] for a Google Cloud Platform account, then go to the [Cloud Console][2] and create a new Project. Name it anything you like.

2. Choose a geographic zone from [this list][3] where your server will run. Then open a Google Cloud Shell session, by clicking on its icon in the upper-right, and then expanding it to its own window if you desire. Now enter the following text, making sure you change `us-central1-a` to your desired zone:

        gcloud config set compute/zone us-central1-a

Network proximity to the server is a key factor in your players' experience, use a zone that's nearest to your expected users!

3. Create an SSH keypair for your server by pasting in the following:

        gcloud compute config-ssh

    You'll need the secret key created in this step to manage the server beyond examining the logs and issuing commands. The key will be printed out by the next step.

4. Now run the following commands, substituting your desired value for `DISK_SIZE`. You can also choose another `MACHINE_TYPE` from this list, but the default type offers excellent performance for a server with around twenty simultaneous players.

        export DISK_SIZE="200GB"
        export MACHINE_TYPE="n1-standard-1"
        git clone https://github.com/benton/k8craft.git
        ./k8craft/bin/setup.sh

  This step will take a few minutes, as it has to: create a new storage disk; start a new virtual machine; attach and format the disk; download the docker images to the host; start the Minecraft and SSH servers; and finally, allocate an external IP address for them.

  At the end of the process, the private SSH key and public IP address of the server are printed out. These are the two pieces of information required to [maintain your server][4], so write down the IP, then copy and paste the key data into a file on your workstation. Keep the key secret!


[1]:https://cloud.google.com/free-trial/
[2]:https://console.cloud.google.com/home/dashboard
[3]:https://cloud.google.com/compute/images/zones_diagram.svg
[4]:https://github.com/benton/k8craft/blob/master/doc/maintenance.md
