Tearing Down your Google Cloud Minecraft Server
======

1. From the [Cloud Console][1], open a Google Cloud Shell session and enter the following text, making sure you change `us-central1-a` to your server's zone:

        gcloud config set compute/zone us-central1-a

2. Now paste in this:

        git clone https://github.com/benton/k8craft.git
        ./k8craft/bin/teardown.sh

    The Minecraft and SSH servers will be stopped (their Docker containers terminated). Then you will be prompted as to whether you want to delete the cluster – this is recommended (unless you plan to immediately re-run `./bin/deploy.rb`, which will start the containers up again).

    Finally, you'll be prompted whether to delete the disk holding all the server's data. Use the tools described in the [maintenance instructions][2] to transfer the data offsite if you need to.

**Deleting the services, the cluster and the disk should stop accruing Google Cloud charges for this software, but if you're done with the disk, the safest thing to do is delete the Project entirely!**

[1]:https://console.cloud.google.com/home/dashboard
[2]:https://github.com/benton/k8craft/blob/master/doc/maintenance.md