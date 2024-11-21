rm -rf ./updates/*

#GIT_BRANCH=KKoukiou-certificates-download
# adds --category
GIT_BRANCH=${RVM_PYKICKSTART_TAG:-edns-cert-initramfs}
PYKICKSTART_GIT=${RVM_PYKICKSTART_DIR:-/home/rvykydal/work/features/edns-certs/pykickstart}
UPDATES_DIR=updates/usr/lib/python3.13/site-packages/pykickstart

mkdir -p ${UPDATES_DIR}/commands
mkdir -p ${UPDATES_DIR}/handlers

cd $PYKICKSTART_GIT
git checkout $GIT_BRANCH
cd -

cp $PYKICKSTART_GIT/pykickstart/commands/autopart.py $UPDATES_DIR/commands/autopart.py
cp $PYKICKSTART_GIT/pykickstart/handlers/f41.py $UPDATES_DIR/handlers/f41.py

scripts/makeupdates -k
