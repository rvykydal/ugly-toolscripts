#!/bin/bash

# rv-virt-ssh.sh
# rv-virt-ssh.sh /bin/bash -s < script.sh argument
#

if [ -z ${1} ]; then
    echo "usage: $0 <NAME>"
fi

NAME=$1
shift

CONFIG_FILE=${NAME}.rvm

source ${CONFIG_FILE}

echo SSH connecting to machine ${NAME} ${SSH_ADDR}:${SSH_PORT}
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p ${SSH_PORT} root@${SSH_ADDR} $@
