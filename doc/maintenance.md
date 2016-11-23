How to Maintain your Google Cloud Minecraft Server
======

Simple Tasks: checking the log and issuing server commands
------
Simple management tasks like checking the log and issuing server commands are best performed with the [Google Cloud Console][1]'s Cloud Shell. Open a Google Cloud Shell session by clicking on its icon in the upper-right, and then expand it to its own window if you desire.

Now enter the following text, making sure you change `us-central1-a` to your desired zone:

        gcloud config set compute/zone us-central1-a


### Checking the current server log

Run something like this from the Cloud Shell, after the above setup:
* `./k8craft/bin/logs.sh` - prints the full server log since restart
* `./k8craft/bin/logs.sh --tail=10` - prints just the last 10 lines
* `./k8craft/bin/logs.sh --tail=10 -f` - prints the last 10 lines and follows the log (type `CTRL-C` to stop)


### Issuing server commands

Run this from the Cloud Shell, after the above setup:

    ./k8craft/bin/connect.sh

This will connect you to the Minecraft console where you can issue commands like `help` or `restart`. Type `CTRL-D` to disconnect. Note that no prompt is shown before input – just start typing. Also note that `CTRL-C` stops the server! (But it will restart automatically.)

Also, remember that once you `op [PLAYER]`, then that player can issue server commands from Minecraft itself. So consider doing that for your own account.


Complex Tasks: changing settings and installing plugins
------
More complex tasks should be carried out by creating, editing or deleting files in the server's Minecraft data directory. To do this, you connect to the server's public IP address over port 22 using the private key generated during setup, and any software that speaks the venerable `SSH` protocol. If you understand that last sentence, then you probably already know how to use `ssh`, `scp`, and `rsync`, which are all installed for your file-transferring pleasure. If not, don't worry – there are free and simple graphical tools you can use as well. But using either method requires a bit of preliminary setup:

1. First, create a file in your `$HOME/.ssh` directory called `k8craft.key` and paste in the contents of the private key that was printed out during setup.

  On OS X, you can enter the following into the Terminal app:

        mkdir -p ~/.ssh && chmod 0700 ~/.ssh
        touch ~/.ssh/k8craft.key && chmod 0700 ~/.ssh/k8craft.key
        open -t ~/.ssh/k8craft.key

  The `chmod` commands are necessary to secure the key; many SSH clients will not trust the key otherwise.

2. Now paste the SSH client configuration block that was printed during setup into `$HOME/.ssh/config`. In an OS X Terminal:

        touch ~/.ssh/config && open -t ~/.ssh/config


### Transferring files to the server, and editing config files

No matter which method you use to manipulate the files on your server, you should use the username `mc` _(most SSH clients will read this username from your `.ssh/config` file if you simply request host `k8craft`)_.

Once you're connected, the Minecraft data is stored in `/data`.

Here are your options:

1. If you want to use a graphical tool, I recommend [Cyberduck][2] – it's free, open-source, and integrates nicely with both Windows and OS X. Best of all, it allows you to use a single keystroke (`CMD-K` on OS X) to download a text file and open it in your editor, after which Cyberduck will upload it *back* to the server whenever you save the file! This is super-handy for editing `server.properties` and `spigot.yml`.

2. Traditional command-line tools are great for automation. Here are some examples:

        # list my existing plugins
        ssh k8craft ls -1 /data/plugins/

        # upload a plugin:
        scp ~/Downloads/myplugin.jar k8craft:/data/plugins/

        # one-way sync a folder of plugins to the server:
        rsync -v ~/projects/myserver/plugins/ k8craft:/data/plugins/

3. You can also just type `ssh k8craft` to get a `bash` shell in your SSH container, where you can use `curl`, `wget`, `unzip` and a few other basic tools to download files directly to the server without putting them on your workstation at all! `edit`, `vi`, and `vim` are installed if you want to edit text files in the terminal (you beautiful nerd).

Finally, remember that making changes to config files almost always requires issuing a `restart` command to take effect.


[1]:https://console.cloud.google.com/home/dashboard
[2]:https://cyberduck.io/
