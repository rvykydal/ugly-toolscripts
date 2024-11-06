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
cp $CWD/loader sbin/loader
cp $CWD/init sbin/init
#strip -s -o sbin/loader $CWD/loader
#strip -s -o sbin/init $CWD/init
#/bin/bash
#(find . |cpio -c -o |gzip -9) > $CWD/$TMPINITRD
(find . |cpio -c -o |xz --format=lzma -9) > $CWD/$TMPINITRD
mv -f $CWD/$TMPINITRD $INITRD
popd
#echo $tmpdir
rm -rf $tmpdir

