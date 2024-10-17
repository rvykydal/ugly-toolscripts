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
TAG=${1:-vi_$UUID}

BOOT_ISO=${BOOT_ISO:-boot.iso}

RAM=2048
CPUS=1

echo Tag: ${TAG}
echo Iso: ${BOOT_ISO}

virt-install \
        --name ${TAG} \
        --memory ${RAM} \
        --noautoconsole \
        --connect "qemu:///session" \
        --vcpus ${CPUS} \
        --rng /dev/random \
        --osinfo require=off,detect=on \
        --graphics vnc,listen=0.0.0.0 \
        --video virtio \
        --network user,model=virtio \
        --extra-args "inst.sshd inst.debug debug=1" \
        --location ./${BOOT_ISO},kernel=images/pxeboot/vmlinuz,initrd=images/pxeboot/initrd.img \
        --disk none \
#        --boot uefi \
#        --initrd-inject ks.${TAG}.cfg \
#       --disk \

# network: user or bridge or solution from machine_install.py

#virt-install ['-n', 'kstest-reboot-uefi_(1efabf86-677d-4644-b904-3de70cf756c7)', '-r', '2048', '--noautoconsole', '--vcpus', '1', '--rng', '/dev/random', '--osinfo', 'require=off,detect=on', '--graphics', 'vnc,listen=0.0.0.0', '--video', 'virtio', '--initrd-inject', '/opt/kstest/kickstart-tests/reboot-uefi.ks', '--disk', 'path=/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/disk-a.img,cache=unsafe,bus=virtio', '--network', 'user,model=virtio', '--disk', 'path=/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/boot.iso,device=cdrom,readonly=on,shareable=on', '--boot', 'uefi', '--extra-args', 'inst.ks=file:/reboot-uefi.ks debug=1 inst.debug rd.shell=0 rd.emergency=poweroff inst.kernel.hung_task_timeout_secs=1200 inst.stage2=hd:CDLABEL=Fedora-E-dvd-x86_64-rawh', '--location', '/var/tmp/kstest-reboot-uefi.2024_10_15-15_02_43.jhcdqmz4/boot.iso,kernel=images/pxeboot/vmlinuz,initrd=images/pxeboot/initrd.img', '--channel', 'tcp,host=127.0.0.1:45987,mode=connect,target_type=virtio,name=org.fedoraproject.anaconda.log.0', '--wait', '30']

