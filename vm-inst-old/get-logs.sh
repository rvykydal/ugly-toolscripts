#!/bin/sh

IP=10.43.136.124

if [ -n "$1" ]; then
  IP=$1
fi

SUBDIR="latest"
if [ -n "$2" ]; then
  SUBDIR=$2
fi

CWD=$(pwd)
DIR=logs-testvm/${SUBDIR}
rm -rf ./$DIR
mkdir -p $DIR

#ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" root@10.34.102.106 'journalctl -a > /tmp/jctl.log; dmesg > /tmp/dmesg.log'
#ssh root@$IP 'journalctl -a > /tmp/jctl.log; dmesg > /tmp/dmesg.log'
#ssh root@$IP 'journalctl -a > /tmp/jctl.log; nmcli con > /tmp/nmcli.log; nmcli con show ens3 >> /tmp/nmcli.log'
ssh root@$IP 'journalctl -a > /tmp/jctl.log; blkid > /tmp/blkid.log ; lsblk > /tmp/lsblk.log; nmcli con > /tmp/nmcli.log; nmcli dev >> /tmp/nmcli.log; ip a >> /tmp/nmcli.log; cat /run/NetworkManager/system-connections/* > /tmp/runcons.log; cat /etc/NetworkManager/system-connections/* > /tmp/etccons.log; cp /root/lorax-packages.log /tmp'
rsync -avzh root@$IP:/tmp/*log $DIR
rsync -avzh root@$IP:/mnt/sysimage/root/*.cfg $DIR
rsync -avzh root@$IP:/mnt/sysimage/etc/fstab $DIR
rsync -avzh root@$IP:/tmp/anaconda* $DIR

