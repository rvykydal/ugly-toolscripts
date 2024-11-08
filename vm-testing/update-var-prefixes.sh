#!/bin/bash
#sed -i "s/BOOT_ISO=/RVM_BOOT_ISO=/g" $@

vars="BOOT_ISO= RAM= CPUS= SSH_ADDR= SSH_PORT= EXTRA_ARGS= KS= KS_FROM_HTTP= KS_FROM_FILE= KS_FROM_CDROM= DISKS= STAGE2_FROM_NFS= UPDATES_IMG= UPDATES_IMG_TAG= UPDATES_IMG_PATH= UPDATES_IMG_CMD= LOGS_CMD= UEFI="

for var in $vars; do
    sed -i "s/#${var}/#RVM_${var}/g" $@
    sed -i "s/^${var}/RVM_${var}/g" $@
done

vars=EXTRA_ARGS
for var in $vars; do
    sed -i "s/{${var}/{RVM_${var}/g" $@
done
