#!/bin/bash

# https://tuxcare.com/blog/the-essential-kvm-cheat-sheet-for-system-administrators/
# https://www.cyberciti.biz/faq/howto-linux-delete-a-running-vm-guest-on-kvm/

# virsh list
# virsh list-all
# virsh dominfo
# virsh domstate

# virsh start
# virsh reboot
# virsh stop
# virsh destroy
# virsh undefine
# virsh dumpxml


UUID=`uuid`
NAME=${1:-rvm-$UUID}

CONFIG_FILE=${NAME}.rvm

source $CONFIG_FILE

BOOT_ISO=${BOOT_ISO:-boot.iso}

RAM=${RAM:-2048}
CPUS=${CPUS:-1}

_RANDOM_N=$((10 + $RANDOM % 90))
RANDOM_SSH_ADDR=127.0.0.${_RANDOM_N}
RANDOM_SSH_PORT=22${_RANDOM_N}
SSH_ADDR=${SSH_ADDR:-$RANDOM_SSH_ADDR}
SSH_PORT=${SSH_PORT:-$RANDOM_SSH_PORT}

if [ ! -f ${CONFIG_FILE} ]; then
    echo Creating configuration file ${CONFIG_FILE}
    touch ${CONFIG_FILE}
fi

grep ^SSH_ADDR= ${CONFIG_FILE} || echo Adding SSH_ADDR to config file; echo "SSH_ADDR=${RANDOM_SSH_ADDR}" >> ${CONFIG_FILE}
grep ^SSH_PORT= ${CONFIG_FILE} || echo Adding SSH_PORT to config file; echo "SSH_PORT=${RANDOM_SSH_PORT}" >> ${CONFIG_FILE}

cat << EOF
config:   ${CONFIG_FILE}
NAME:     ${NAME}
RAM:      ${RAM}
CPUS:     ${CPUS}
BOOT_ISO: ${BOOT_ISO}
SSH_ADDR: ${SSH_ADDR}
SSH_PORT: ${SSH_PORT}
EOF

virt-install \
        --name ${NAME} \
        --memory ${RAM} \
        --noautoconsole \
        --connect "qemu:///session" \
        --vcpus ${CPUS} \
        --rng /dev/random \
        --osinfo require=off,detect=on \
        --graphics vnc,listen=0.0.0.0 \
        --video virtio \
        --extra-args "inst.sshd inst.debug debug=1" \
        --location ./${BOOT_ISO},kernel=images/pxeboot/vmlinuz,initrd=images/pxeboot/initrd.img \
        --disk none \
        --network none \
        --qemu-commandline="-netdev user,id=hostnet0,hostfwd=tcp:${SSH_ADDR}:${SSH_PORT}-:22 -device virtio-net-pci,netdev=hostnet0,id=net0,addr=0x16"
#        --network user,model=virtio \
#        --boot uefi \
#        --initrd-inject ks.${NAME}.cfg \
#       --disk \

# network: user or bridge or solution from machine_install.py

#virt-install ['-n', 'kstest-reboot-uefi_(1efabf86-677d-4644-b904-3de70cf756c7)', '-r', '2048', '--noautoconsole', '--vcpus', '1', '--rng', '/dev/random', '--osinfo', 'require=off,detect=on', '--graphics', 'vnc,listen=0.0.0.0', '--video', 'virtio', '--initrd-inject', '/opt/kstest/kickstart-tests/reboot-uefi.ks', '--disk', 'path=/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/disk-a.img,cache=unsafe,bus=virtio', '--network', 'user,model=virtio', '--disk', 'path=/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/boot.iso,device=cdrom,readonly=on,shareable=on', '--boot', 'uefi', '--extra-args', 'inst.ks=file:/reboot-uefi.ks debug=1 inst.debug rd.shell=0 rd.emergency=poweroff inst.kernel.hung_task_timeout_secs=1200 inst.stage2=hd:CDLABEL=Fedora-E-dvd-x86_64-rawh', '--location', '/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/boot.iso,kernel=images/pxeboot/vmlinuz,initrd=images/pxeboot/initrd.img', '--channel', 'tcp,host=127.0.0.1:45987,mode=connect,target_type=virtio,name=org.fedoraproject.anaconda.log.0', '--wait', '30']

