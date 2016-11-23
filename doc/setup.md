How to Run Minecraft Server on the Google Cloud Platform
======

1. [Sign up][1] for a Google Cloud Platform account, then go to the [Cloud Console][2] and create a new Project. Name it anything you like.

2. Choose a geographic zone from [this list][3] where your server will run. Then open a Google Cloud Shell session, by clicking on its icon in the upper-right, and then expanding it to its own window if you desire. Now enter the following text, making sure you change `us-central1-a` to your desired zone:

        gcloud config set compute/zone us-central1-a

    Network proximity to the server is a big factor in your players' experience, so use the zone that's nearest to your expected users!

3. If you've never used the Cloud Shell before, configure it for accessing your virtual machines. The key created in this step is *not* the key you'll need to manage your server, so don't worry about saving it.

        gcloud compute config-ssh

4. Now run the following commands, substituting your desired value for `DISK_SIZE`. You can also choose another `MACHINE_TYPE` from [this list][5], but the default type offers excellent performance for a server with around twenty simultaneous players.

        export DISK_SIZE="200GB"
        export MACHINE_TYPE="n1-standard-1"
        git clone https://github.com/benton/k8craft.git
        ./k8craft/bin/setup.sh

  This is the only complex step. It will take a few minutes, because it has to:
  * create a new storage disk;
  * start a "cluster" of just a single virtual machine;
  * attach and format the disk;
  * download the docker images to the host;
  * start the Minecraft and SSH servers; and finally,
  * allocate an external IP address.

  At the end of the process, the three bits of information required to [maintain your server][4] are printed out. You'll want to save all three on your workstation:

  * the private SSH key, which you should save as `$HOME/.ssh/k8craft.key`. Keep it secret; keep it safe!
  * Some SSH client configuration, to paste into `$HOME/.ssh/config`
  * the public IP address of the server, for both SSH and Minecraft

  Further details on how to use this information is in the [maintenance instructions][4], but you should be able to connect with Minecraft right away!


[1]:https://cloud.google.com/free-trial/
[2]:https://console.cloud.google.com/home/dashboard
[3]:https://cloud.google.com/compute/images/zones_diagram.svg
[4]:https://github.com/benton/k8craft/blob/master/doc/maintenance.md
[5]:https://cloud.google.com/compute/docs/machine-types
