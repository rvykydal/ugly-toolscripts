#!/bin/bash

# Break in cmdline stage: rd.break=cmdline
# Run
# /upd-dracut.sh d
# exit

if [ "$1" == "d" ]; then
    # We are in dracut, unpack the tarball

    echo Running in dracut

    mount -o remount,rw /usr
    mount -o remount,rw /

    cd /
    tar -xvzf *.tar.gz

fi

if [ "$1" == "l" ]; then
    # We are in devel env, create the tarball

    echo Running in devel env

    rm -rf ${RVM_INJECT_DIR}
    mkdir ${RVM_INJECT_DIR}

    mkdir -p ${RVM_INJECT_DIR}/usr/sbin
    cp anaconda/dracut/parse-kickstart ${RVM_INJECT_DIR}/usr/sbin

    cd ${RVM_INJECT_DIR}
    tar -czf ${RVM_INJECT_TARBALL} .
    cd -

fi
