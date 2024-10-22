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

if [ -z $1 ]; then
    echo "Usage: $0 <NAME> [info|force]"
    ls -1 *.rvm
    exit 1
fi

NAME=${1:-rvm-$UUID}

CMD=${2}

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

grep -q ^SSH_ADDR= ${CONFIG_FILE} || echo "SSH_ADDR=${RANDOM_SSH_ADDR}" >> ${CONFIG_FILE}
grep -q ^SSH_PORT= ${CONFIG_FILE} || echo "SSH_PORT=${RANDOM_SSH_PORT}" >> ${CONFIG_FILE}

echo ------ Config file ${CONFIG_FILE}
cat ${CONFIG_FILE}
echo ------

if [ "$CMD" == "info" ]; then
    echo ------ virsh dominfo $NAME
    virsh dominfo $NAME
    echo ------
    echo ------ kickstart $KS
    cat ${KS}
    echo ------
    exit 0
fi

if [ "$CMD" == "ks" ]; then
    $EDITOR ${KS}
    exit 0
fi

if [ "$CMD" == "conf" ]; then
    $EDITOR ${CONFIG_FILE}
    exit 0
fi

if [[ $(virsh dominfo $NAME) ]]; then
    echo "Domain '$NAME' already exists."
    if [ "$CMD" == "force" ]; then
        echo "Removing '$NAME'"
        virsh destroy $NAME
        virsh undefine $NAME
    else
        exit 1
    fi
fi

KS_FILE="ks.${NAME}.rvm.cfg"

if [ ${KS_FROM_FILE} ]; then
    echo "Injecting kickstart '$KS' via './$KS_FILE'"
    cp $KS ./${KS_FILE}
    echo "Configuring injected kickstart to be used"
    EXTRA_KS_ARGS="inst.ks=file:/${KS_FILE}"
else
    touch $KS_FILE
    echo "Injecting '$KS_FILE'"
fi

if [ ${KS_FROM_HTTP} ]; then
    KS_HTTP_URL="http://10.43.136.2/users/rv/ks/${KS_FILE}"
    echo "Uploading kickstart $KS to $KS_HTTP_URL"
    scp $KS 10.43.136.2:/mnt/data/users/rv/ks/${KS_FILE}
    echo "Configuring uploaded kickstart to be used"
    EXTRA_KS_ARGS="inst.ks=${KS_HTTP_URL}"
fi

KS_ISO=rvm_ks.iso
KS_ISO_FILE=ks.cfg
if [ ${KS_FROM_CDROM} ]; then
    echo "Passing kickstart '$KS' via CDROM './$KS_ISO'"
    cp $KS ${KS_ISO_FILE}
    mkisofs -V RVM_KS -o $KS_ISO ${KS_ISO_FILE}
    echo "Configuring CDROM with kickstart to be used"
    EXTRA_KS_ARGS="inst.ks=cdrom:sr1:/${KS_ISO_FILE}"
    KS_CDROM_OPTION="--disk path=./${KS_ISO},device=cdrom,readonly=on,shareable=on"
fi

MNT_DIR=rvm_mntdir

# sudo mount -t nfs -oro,nfsvers=3,nolock 10.43.136.2:/mnt/data/users/rv/s2/rvm m
if [ ${STAGE2_FROM_NFS} ]; then
    if [ ${STAGE2_FROM_NFS} == "reload" ]; then
        echo "Uploading install.img."
        mkdir ${MNT_DIR}
        sudo mount ${BOOT_ISO} ${MNT_DIR}
        scp ${MNT_DIR}/images/install.img 10.43.136.2:/mnt/data/users/rv/s2/rvm/images
        sudo umount ${MNT_DIR}
        rmdir ${MNT_DIR}
    fi
    STAGE2_ARG=inst.stage2=nfs:10.43.136.2:/mnt/data/users/rv/s2/rvm
fi

set +x

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
        --qemu-commandline="-netdev user,id=hostnet0,hostfwd=tcp:${SSH_ADDR}:${SSH_PORT}-:22 -device virtio-net-pci,netdev=hostnet0,id=net0,addr=0x16" \
        --extra-args "${EXTRA_ARGS}" \
        --initrd-inject "./${KS_FILE}" \
        --extra-args "${EXTRA_KS_ARGS}" \
        ${KS_CDROM_OPTION} \
        --extra-args ${STAGE2_ARG} \
#        --disk path=./${KS_ISO},device=cdrom,readonly=on,shareable=on \
#        --network user,model=virtio \
#        --boot uefi \
#        --initrd-inject ks.${NAME}.cfg \
#       --disk \

set -x

# network: user or bridge or solution from machine_install.py

# ssh -o ControlPath=/tmp/.cockpit-test-resources/ssh-%C-122182 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2201 root@127.0.0.2

# qemu-system-x86_64 -enable-kvm -name libvirt_debbox -S -machine pc-i440fx-2.1,accel=kvm -m 512 -smp 1,sockets=1,cores=1,threads=1 -uuid 4b9c09e6-a78e-4bd3-81d6-f8f24b0d9a27 -no-user-config -nodefaults -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/libvirt_debbox.monitor,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown -boot c -usb -drive file=/var/lib/libvirt/images/libvirt_debbox.img,if=none,id=drive-virtio-disk0,format=qcow2 -device virtio-blk-pci,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0 -netdev tap,fd=25,id=hostnet0,vhost=on,vhostfd=26 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:ec:12:54,bus=pci.0,addr=0x5 -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0 -vnc 127.0.0.1:0 -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4

#virt-install ['-n', 'kstest-reboot-uefi_(1efabf86-677d-4644-b904-3de70cf756c7)', '-r', '2048', '--noautoconsole', '--vcpus', '1', '--rng', '/dev/random', '--osinfo', 'require=off,detect=on', '--graphics', 'vnc,listen=0.0.0.0', '--video', 'virtio', '--initrd-inject', '/opt/kstest/kickstart-tests/reboot-uefi.ks', '--disk', 'path=/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/disk-a.img,cache=unsafe,bus=virtio', '--network', 'user,model=virtio', '--disk', 'path=/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/boot.iso,device=cdrom,readonly=on,shareable=on', '--boot', 'uefi', '--extra-args', 'inst.ks=file:/reboot-uefi.ks debug=1 inst.debug rd.shell=0 rd.emergency=poweroff inst.kernel.hung_task_timeout_secs=1200 inst.stage2=hd:CDLABEL=Fedora-E-dvd-x86_64-rawh', '--location', '/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/boot.iso,kernel=images/pxeboot/vmlinuz,initrd=images/pxeboot/initrd.img', '--channel', 'tcp,host=127.0.0.1:45987,mode=connect,target_type=virtio,name=org.fedoraproject.anaconda.log.0', '--wait', '30']


virt-viewer $NAME &
