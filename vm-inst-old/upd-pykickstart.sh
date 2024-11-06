rm -rf ./updates/*

PYKICKSTART_GIT=/home/rvykydal/work/git/rvykydal/pykickstart
UPDATES_DIR=updates/usr/lib/python3.12/site-packages/pykickstart

mkdir -p ${UPDATES_DIR}/commands
mkdir -p ${UPDATES_DIR}/handlers

cp $PYKICKSTART_GIT/pykickstart/handlers/f40.py $UPDATES_DIR/handlers/f40.py
cp $PYKICKSTART_GIT/pykickstart/commands/network.py $UPDATES_DIR/commands/network.py

scripts/makeupdates -k
scp updates.img 10.43.136.2:/mnt/data/users/rv/updates.teamd-deprecate.img

virsh -c qemu+ssh://root@10.43.136.4/system reboot rv_test
