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
* Runs [Spigot][2] or vanilla Minecraft server

* Built on [Google Container Engine][4], which uses best-of-breed infrastructure and software ([Kubernetes][5]/[Docker][6]/Linux4.x) to outperform other cloud providers on reliability, latency and throughput. For Minecraft, this means more uptime, less server lag and faster chunk loading for users!

* Free for 2 months. GCP is currently offering a 2-month/US$300 [free trial][11], which is enough to run quite a powerful server for those 2 months.

* Lightweight, efficient and secure - runs as a pair of Docker containers that share the server's Minecraft data volume, but are otherwise isolated: one container for the Java process and one container for the SSH daemon. To maximize available RAM and CPU for the Java process, no web server front-end or other extraneous processes are run. 100% open-source.

* Fast and easy [setup][7] and [teardown][8].

----------------
Installation
----------------
Create a working server using the [Google Cloud Console][9]. See the [setup document][7] for detailed instructions.

----------------
Server Management
----------------
Simple management tasks like checking the log and issuing server commands can be done with a web browser. However, adjusting server settings or installing plugins must be performed by managing the server's data directory and config files. See the [server maintenance instructions][10] for details.

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
[11]:https://cloud.google.com/free-trial/
