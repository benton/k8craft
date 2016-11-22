FROM benton/java:8
ARG SPIGOT_V

# OS package list update and auxiliary tools
RUN apt-get -q2 update &&\
  apt-get -y install git tar curl unzip software-properties-common &&\
  mkdir -p /build

# oracle java 8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true \
  | debconf-set-selections
RUN add-apt-repository -y ppa:webupd8team/java && apt-get update && \
  apt-get -y install oracle-java8-installer oracle-java8-set-default
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle

# build spigot
WORKDIR /build
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN git config --global --unset core.autocrlf || true
RUN java -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true \
  -Dmaven.wagon.http.ssl.ignore.validity.dates=true -jar BuildTools.jar --rev ${SPIGOT_V}
RUN cp spigot-${SPIGOT_V}.jar spigot.jar

# Copy Vanilla minecraft
RUN cp work/minecraft_server.${SPIGOT_V}.jar .
RUN cp minecraft_server.${SPIGOT_V}.jar minecraft_server.jar

# copy output to volume
VOLUME /pkg
RUN ls -l *.jar
ENTRYPOINT ["bash", "-c"]
CMD ["cp -fv /build/*.jar /pkg/"]
