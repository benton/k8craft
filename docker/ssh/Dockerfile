FROM phusion/baseimage:latest
ARG DEFAULT_USER

RUN apt-get -q2 -y update
ADD ssh-extra-packages.txt /root/
RUN cat /root/ssh-extra-packages.txt | xargs apt-get -y install bash

ENV SSH_USER=${DEFAULT_USER} \
    SSH_UID=999 \
    SSH_GID=999 \
    SSH_KEY=""
VOLUME /data

RUN mkdir -p /etc/my_init.d
COPY add-ssh-user.sh /etc/my_init.d

RUN echo "UsePAM yes" >>/etc/ssh/sshd_config
RUN rm -f /etc/service/sshd/down

EXPOSE 22
