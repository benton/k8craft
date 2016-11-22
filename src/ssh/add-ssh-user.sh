#!/usr/bin/env bash

# create group
if ! $(grep ^$SSH_USER /etc/group >/dev/null 2>&1) ; then
  echo "Creating group ${SSH_USER}..."
  addgroup --gid $SSH_GID $SSH_USER
fi

# create user
if ! $(id $SSH_USER >/dev/null 2>&1) ; then
  echo "Creating user ${SSH_USER}..."
  useradd $SSH_USER -m --gid $SSH_GID --uid $SSH_UID -s /bin/bash
fi

# add hooks to data dir
echo "cd /data" >>/home/${SSH_USER}/.profile
ln -sf /data /home/${SSH_USER}/data

echo "Installing SSH key ${SSH_KEY}..."
KEYFILE="/home/${SSH_USER}/.ssh/authorized_keys"
KEYDIR=$(dirname $KEYFILE)
mkdir -p $KEYDIR && chmod 0700 $KEYDIR
echo "$SSH_KEY" >${KEYFILE}
chmod 0600 ${KEYFILE} && chown -R ${SSH_USER}:${SSH_USER} $KEYDIR
