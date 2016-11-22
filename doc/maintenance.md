How to Maintain your Google Cloud Minecraft Server
======
Simple management tasks like checking the log and issuing server commands are best performed with the [Google Cloud Console][1]'s Cloud Shell. You open a Google Cloud Shell session, by clicking on its icon in the upper-right, and then expanding it to its own window if you desire.

Now enter the following text, making sure you change `us-central1-a` to your desired zone:

        gcloud config set compute/zone us-central1-a
        git clone https://github.com/benton/k8craft.git

If you've used the Cloud Shell for this Project within the last few hours, this step may not be required.


Checking the current server log
------
Run something like this from the Cloud Shell, after the above setup:
* `./k8craft/bin/logs.sh` - prints the full server log since restart
* `./k8craft/bin/logs.sh --tail=10` - prints just the last 10 lines
* `./k8craft/bin/logs.sh --tail=10 -f` - prints the last 10 lines and follows the log (type `CTRL-C` to stop)


Issuing server commands
------
Run this from the Cloud Shell, after the above setup:

    ./k8craft/bin/connect.sh

This will connect you to the Minecraft console where you can issue commands like `help` or `restart`. (Note that no prompt is shown before input – just start typing.)

------

More complex tasks should be carried out with the private key generated during setup, by creating, editing or deleting files in the server's Minecraft data directory. To do this, you connect to the server's public IP address over port 22 using any software that speaks the venerable `SSH` protocol.

Transferring files to the server
------
First, you must install the private key and SSH configuration

Editing Server config files
------

[1]:https://console.cloud.google.com/home/dashboard
