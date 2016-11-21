FROM phusion/baseimage:latest
ARG JAVA_V

# OS package list update and auxiliary tools
RUN apt-get -q2 update && apt-get -y install software-properties-common

# oracle java
RUN echo oracle-java${JAVA_V}-installer shared/accepted-oracle-license-v1-1 select true \
  | debconf-set-selections
RUN add-apt-repository -y ppa:webupd${JAVA_V}team/java && apt-get update && \
  apt-get -y install oracle-java${JAVA_V}-installer oracle-java${JAVA_V}-set-default
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_V}-oracle

ENTRYPOINT ["java"]
CMD ["-version"]
