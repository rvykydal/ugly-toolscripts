#!/bin/bash

LOGS_DIR="./rvm-logs"

if [ -z ${1} ]; then
    echo "usage: $0 [LABEL] [RVM_CONFIG]"
    echo "       RVM_CONFIG - download from rvm <RVM_CONFIG>"
    $EDITOR ${LOGS_DIR}
    exit 0
fi

LABEL=$1
RVM_CONFIG=$2

if [ ! -d ${LOGS_DIR} ]; then
    echo "Creating $LOGS_DIR."
    mkdir $LOGS_DIR
fi

DIR=${LOGS_DIR}/${LABEL}

if [ ! -z $RVM_CONFIG ]; then
    source ${RVM_CONFIG}

    if [ ! -d ${DIR} ]; then
        echo "Creating $DIR."
        mkdir $DIR
    fi

    if [ ! -z "$LOGS_CMD" ]; then
        echo "Running pre logs cmd '$LOGS_CMD'"
        ./rv-virt-ssh.sh $RVM_CONFIG $LOGS_CMD
    fi

    echo "Downloading logs '${LABEL}' from '$RVM_CONFIG'"
    rsync -avzh -e "ssh -p $SSH_PORT -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" root@$SSH_ADDR:/tmp/*log $DIR
    rsync -avzh -e "ssh -p $SSH_PORT -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" root@$SSH_ADDR:/tmp/anaconda* $DIR
    rsync -avzh -e "ssh -p $SSH_PORT -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" root@$SSH_ADDR:/run/install/ks.cfg $DIR
    #rsync -avzh -e "ssh -p $SSH_PORT" root@$SSH_ADDR:/mnt/sysimage/root/*.cfg $DIR
fi

if [ ! -d ${DIR} ]; then
    echo "No logs ${DIR} found."
fi

$EDITOR ${DIR}
