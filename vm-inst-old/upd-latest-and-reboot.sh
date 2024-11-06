#!/bin/bash

set +x

scripts/makeupdates

scp updates.img 10.43.136.2:/mnt/data/users/rv/updates.latest.img
virsh -c qemu+ssh://root@10.43.136.4/system reboot rv_test2
