#!/bin/sh

IP=10.43.136.77

if [ -n "$1" ]; then
  IP=$1
fi

CWD=$(pwd)

#ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" root@10.34.102.106 'journalctl -a > /tmp/jctl.log; dmesg > /tmp/dmesg.log'
#ssh root@$IP 'journalctl -a > /tmp/jctl.log; dmesg > /tmp/dmesg.log'

ssh root@$IP 'ip a >> /tmp/net.log ; nmcli con >> /tmp/net.log; cat /etc/sysconfig/network-scripts/ifcfg-* >> /tmp/net.log'

ssh root@$IP 'cat /etc/NetworkManager/system-connections/* >> /tmp/net.log'

ssh root@$IP 'cat /run/NetworkManager/system-connections/* >> /tmp/net.log'

ssh root@$IP 'killall sleep ; sleep 4; echo ================ anaconda network initialization >> /tmp/net.log'

ssh root@$IP 'ip a >> /tmp/net.log ; nmcli con >> /tmp/net.log; cat /etc/sysconfig/network-scripts/ifcfg-* >> /tmp/net.log'

ssh root@$IP 'cat /etc/NetworkManager/system-connections/* >> /tmp/net.log'

ssh root@$IP 'echo =============== cmdline >> /tmp/net.log ; grep "Command line" /tmp/syslog >> /tmp/net.log; echo ================= ks.cfg >> /tmp/net.log; cat /run/install/ks.cfg >> /tmp/net.log'

rsync -avzh root@$IP:/tmp/*log $CWD
rsync -avzh root@$IP:/tmp/anaconda* $CWD

