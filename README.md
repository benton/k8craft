k8craft - Minecraft Server on the Google Cloud Platform
================
Fast and simple setup of Minecraft/Spigot server on Google's infrastructure.

----------------
Overview
----------------
This collection of scripts and instructions allows anyone with a [Google Cloud Platform][1] account to:
* Spin up a low-cost, highly performant Minecraft or [Spigot][2] server in under 10 minutes, using only a web browser;
* Perform `restart` and other server console commands using the browser; and
* Manage the server's data directory over the SSH/SFTP protocol, with graphical tools like [Cyberduck][3], or command-line tools like `scp` and `rsync`.

----------------
Features
----------------
* Built on [Google Container Engine][4], which uses best-of-breed software  ([Kubernetes][5]/[Docker][6]/Linux4.x) and infrastructure to outperform other cloud providers on reliability and throughput metrics, for a given price point. For Minecraft, this means less server lag and faster chunk loading for your users! Container Engine make sure your server stays running, even in the face of hardware failures.

* Lightweight, efficient and secure - Runs as two Docker containers that share the server's Minecraft data directory, but are otherwise isolated: one container for the Java process and one container for the SSH daemon. To maximize available RAM and CPU for the Java process, no web server front-end or other extraneous processes are run.

* Fast and easy [setup][7] and [teardown][8].

----------------
Installation
----------------
Creating a working server does not require any software beyond a web browser for using the [Google Cloud Console][9]. See the [setup document][7] for detailed instructions.

----------------
Server Management
----------------
Simple management tasks like checking the log and issuing server commands are easily done with a web browser. However, adjusting server settings or installing plugins should be performed by managing the server's data directory and config files. See the [server maintenance instructions][10] for details.

----------------
Contribution / Development
----------------
After installing Docker and `git`, you can adjust / rebuild the 2 Docker images like this:

    git clone https://github.com/benton/k8craft.git
    cd k8craft
    docker-compose run spigot-build
    docker-compose build spigot
    docker-compose build ssh

Run the server locally, with `k8craft/data` as the data directory:

    docker-compose up spigot

---
This software was created by Benton Roberts _(benton@bentonroberts.com)_



[1]:https://cloud.google.com/
[2]:https://www.spigotmc.org/
[3]:https://cyberduck.io/
[4]:https://cloud.google.com/container-engine/
[5]:http://kubernetes.io/
[6]:https://www.docker.com/
[7]:https://github.com/benton/k8craft/blob/master/doc/setup.md
[8]:https://github.com/benton/k8craft/blob/master/doc/teardown.md
[9]:https://console.cloud.google.com/home/dashboard
[10]:https://github.com/benton/k8craft/blob/master/doc/maintenance.md
