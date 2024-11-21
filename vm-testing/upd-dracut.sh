#!/bin/bash

if [ "$1" == "d" ]; then
    # We are in dracut

    echo Running in dracut

    mount -o remount,rw /usr
    mount -o remount,rw /

    cd /
    tar -xvzf *.tar.gz

fi

RVM_PYKICKSTART_DIR=${RVM_PYKICKSTART_DIR:-./pykickstart}
RVM_PYKICKSTART_TAG=${RVM_PYKICKSTART_TAG:-KKoukiou-certificates-download}

if [ "$1" == "local" ]; then
    # We are in devel env, create the tarball

    echo Running in devel env

    rm -rf ${RVM_INJECT_DIR}
    mkdir ${RVM_INJECT_DIR}

    echo Updating dracut module
    mkdir -p ${RVM_INJECT_DIR}/usr/sbin
    cp anaconda/dracut/parse-kickstart ${RVM_INJECT_DIR}/usr/sbin

    echo Updating pykickstart
    mkdir -p ${RVM_INJECT_DIR}/usr/lib/python3.13/site-packages/pykickstart
    cd ${RVM_PYKICKSTART_DIR}
    git checkout ${RVM_PYKICKSTART_TAG}
    cd -
    cp ${RVM_PYKICKSTART_DIR}/pykickstart/base.py ${RVM_INJECT_DIR}/usr/lib/python3.13/site-packages/pykickstart
    cp ${RVM_PYKICKSTART_DIR}/pykickstart/parser.py ${RVM_INJECT_DIR}/usr/lib/python3.13/site-packages/pykickstart
    cp ${RVM_PYKICKSTART_DIR}/pykickstart/sections.py ${RVM_INJECT_DIR}/usr/lib/python3.13/site-packages/pykickstart

    cd ${RVM_INJECT_DIR}
    tar -czf ${RVM_INJECT_TARBALL} .
    cd -

fi

if [ "$1" == "n" ]; then
    ( nmcli dev list || nmcli dev show ) 2>/dev/null | grep DNS
fi

if [ "$1" == "l" ]; then
    echo "Dumping log info"
    journalctl -a | grep parse-kickstart
    ls /run/install/certificates/plain/etc/pki/ca-trust/extracted/pem
    ls /run/install/certificates/global/etc/pki/ca-trust/extracted/pem
fi
