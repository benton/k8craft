FROM benton/java:8

# OS package list update and auxiliary tools
RUN apt-get -q2 update && apt-get -y install rsync sudo

# dedicated user: mc
RUN addgroup --gid 999 mc
RUN useradd mc -m --gid 999 --uid 999 -s /bin/bash

# Install build artifacts from local pkg directory
COPY pkg/*.jar /build/
RUN echo "eula=true" > /build/eula.txt

# dedicated data volume
VOLUME /data
WORKDIR /data
RUN chown mc.mc /data
RUN echo "cd /data" >>/home/mc/.profile

# run startup script as user mc
COPY src/spigot/start-spigot.sh /usr/local/bin/
# USER mc
ENV SERVER_JAR="spigot" MAX_RAM="1G"
ENTRYPOINT ["start-spigot.sh"]
