#!/bin/bash

# rv-virt-ssh.sh
# rv-virt-ssh.sh edns1.rvm /bin/bash -s < script.sh argument
#

if [ -z ${1} ]; then
    echo "usage: $0 <RVM_CONFIG>"
fi

RVM_CONFIG=$1
shift

source ${RVM_CONFIG}

echo SSH connecting to machine ${RVM_CONFIG} ${SSH_ADDR}:${SSH_PORT}
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p ${SSH_PORT} root@${SSH_ADDR} $@
