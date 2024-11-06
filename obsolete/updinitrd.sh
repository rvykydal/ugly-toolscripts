#!/bin/sh

set -x

if [ $# -ne 1 ] ; then
	echo "Usage: $0 <initrd>"
	exit 1
fi

CWD=$(pwd)

INITRD=$(readlink -f $1)
TMPINITRD=initrd.img-$$

if [ ! -f $CWD/loader ] ; then
	echo "Missing loader"
	exit 1
fi

if [ ! -f $CWD/init ] ; then
	echo "Missing init"
	exit 1
fi

tmpdir=$(mktemp -d)
chmod 0777 $tmpdir
pushd $tmpdir
xzcat -dc $INITRD |cpio -id
#gzip -dc $INITRD |cpio -id
strip -s -o sbin/loader $CWD/loader
strip -s -o sbin/init $CWD/init
#/bin/bash
if [ -f $CWD/gdbserver ] ; then
	if [ -f $CWD/libthread_db-1.0.so ] ; then
		echo "adding gdbserver"
		mkdir usr/bin
		cp $CWD/gdbserver usr/bin/gdbserver
		cp $CWD/libthread_db-1.0.so lib/libthread_db.so.1
	else
		echo "missing libthread_db-1.0.so, not adding gdbserver"
	fi	
fi
if [ -f $CWD/busybox ] ; then
	echo "adding busybox"
	cp $CWD/busybox usr/sbin/busybox
fi
if [ -f $CWD/ping ] ; then
	echo "adding ping"
	cp $CWD/ping sbin/ping
fi
if [ -d $CWD/pykickstart ] ; then
	echo "updating pykickstart"
	rsync -avz $CWD/pykickstart usr/lib/python2.7/site-packages
fi

# iscsi
#if [ -d $CWD/iscsi-initiator-utils ] ; then
#	echo "adding iscsi-initiator-utils"
#	cp -ar $CWD/iscsi-initiator-utils/* .
#fi

if [ -f $CWD/iscsiadm ] ; then
	echo "adding iscsiadm"
	cp $CWD/iscsiadm usr/sbin
fi

if [ -f $CWD/iscsiadm ] ; then
	echo "adding iscsiadm for NM"
	cp $CWD/iscsiadm sbin
fi



if [ -f $CWD/nmcli ] ; then
	echo "adding nmcli"
	cp $CWD/nmcli usr/sbin
fi

if [ -f $CWD/vi ] ; then
	echo "adding vi"
	cp $CWD/vi usr/sbin
fi

#(find . |cpio -c -o |gzip -9) > $CWD/$TMPINITRD
(find . |cpio -c -o |xz --format=lzma -9) > $CWD/$TMPINITRD
mv -f $CWD/$TMPINITRD $INITRD
popd
#echo $tmpdir
rm -rf $tmpdir

