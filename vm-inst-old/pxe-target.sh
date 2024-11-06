#!/bin/bash
# pxe-target.sh ostreecontainer-r9 pr5399-2b2b9a77e1a22794f12590295f6e9081ec744053-boot.iso http://download.eng.brq.redhat.com/rhel-9/nightly/RHEL-9/latest-RHEL-9/compose/BaseOS/x86_64/os/

set -x

if [ $# -lt 2 ] ; then
    echo "Usage: $0 <TAG> <BOOT_ISO> <RPM_REPOSITORY>"
    exit 1
fi

TAG=$1
ISO=$2
if [ -n "$3" ]; then
  REPO=inst.repo=$3
fi

COBRA2_IP=10.43.136.2

TMPDIR=$(mktemp -d)
MOUNTDIR=${TMPDIR}/iso
mkdir ${MOUNTDIR}
sudo mount ${ISO} ${MOUNTDIR}
ls ${MOUNTDIR}

TAG_STAGE2_DIR=/mnt/data/users/rv/s2/pxe-target/${TAG}/images
ssh rvykydal@${COBRA2_IP} mkdir -p ${TAG_STAGE2_DIR}
scp ${MOUNTDIR}/images/install.img ${COBRA2_IP}:${TAG_STAGE2_DIR}
TAG_PXE_DIR=/var/lib/tftpboot/linux-install/test/users/rv/pxe-target/${TAG}
ssh rvykydal@${COBRA2_IP} mkdir -p ${TAG_PXE_DIR}
scp ${MOUNTDIR}/images/pxeboot/vmlinuz ${COBRA2_IP}:${TAG_PXE_DIR}
scp ${MOUNTDIR}/images/pxeboot/initrd.img ${COBRA2_IP}:${TAG_PXE_DIR}

sudo umount ${MOUNTDIR}
rm -rf ${TMPDIR}

cat << EOF
label ${TAG}
  menu label ${TAG}
  kernel test/users/rv/pxe-target/${TAG}/vmlinuz
  append initrd=test/users/rv/pxe-target/${TAG}/initrd.img inst.stage2=http://10.43.136.2/u/rv/s2/pxe-target/${TAG}/ ${REPO}
EOF
