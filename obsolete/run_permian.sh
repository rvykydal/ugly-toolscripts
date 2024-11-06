#!/bin/bash


export PYTHONPATH=${PYTHONPATH}:/home/rvykydal/work/git/rvykydal/tclib
export PIPELINEPLUGINS_ENABLE=test

case $1 in
    list)
        grep "^    .[[:alnum:]-]*)$" $(readlink -f $0)
        ;;
    help)
        ./pipeline \
        --help
        ;;
    kstest-dry)
        ./pipeline \
        --debug-log permian.log \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/permian/tests/test_library/kickstart-test/basic/ \
        --override workflows.dry_run=True \
        run_event '{"type":"kstest-poc","bootIso":{"x86_64":"file:///var/tmp/images/boot.iso"},"kstestParams":{"platform":"fedora_rawhide"}}'
        ;;
    webui-4383-dry)
        ./pipeline \
        --debug-log permian.log \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/permian/tests/test_library/anaconda_webui/basic/ \
        --override workflows.dry_run=True \
        run_event '{"type":"test","InstallationSource":{"base_repo_id":"BaseOS","repos":{"BaseOS":{"x86_64":{"os":"http://10.43.136.2/users/rv/webui_repo/pr_4383/os/","kernel":"images/pxeboot/vmlinuz","initrd":"images/pxeboot/initrd.img"}}}}}'
        ;;
    webui-4383-integration)
        ./pipeline \
        --debug-log permian.log \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/permian/tests/test_library/anaconda_webui/integration/ \
        --override workflows.dry_run=False \
        --override AnacondaWebUI.anaconda_repo=https://github.com/velezd/anaconda.git \
        run_event '{"type":"test","InstallationSource":{"base_repo_id":"BaseOS","repos":{"BaseOS":{"x86_64":{"os":"http://10.43.136.2/users/rv/webui_repo/pr_4383/os/","kernel":"images/pxeboot/vmlinuz","initrd":"images/pxeboot/initrd.img"}}}}}'
        ;;
#PYTHONPATH=./tplib PIPELINEPLUGINS_ENABLE=test ./pipeline run_event -d -o "library.directPath=tests/test_library" '{"type": "test", "test": {"testplans": "Anaconda WebUI plugin plan 1"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f37", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
    webui-zdenek-obsolete)
        ./pipeline \
        --debug-log permian.log \
        --override library.directPath=tests/test_library \
        --override workflows.dry_run=False \
        --override AnacondaWebUI.anaconda_repo=https://github.com/velezd/anaconda.git \
        run_event '{"type": "test", "test": {"testplans": "Anaconda WebUI plugin plan 1"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f37", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        ;;
    webui-zdenek)
        ./pipeline \
        --debug-log permian.log \
        --override workflows.dry_run=False \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/anaconda-permian/ui/webui/test/integration \
        --override AnacondaWebUI.anaconda_repo=file:///home/rvykydal/work/git/rvykydal/anaconda-permian \
        run_event '{"type": "github.pr.anaconda", "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        #run_event '{"type": "github.pr.anaconda", "test": {"testplans": "Anaconda WebUI plugin plan 1"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        ;;
    webui-zdenek-cobra) # THIS
        ./pipeline \
        --debug-log permian.log \
        --override workflows.dry_run=False \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/anaconda-permian/ui/webui/test/integration \
        --override AnacondaWebUI.anaconda_repo=file:///home/rvykydal/work/git/rvykydal/anaconda-permian \
        run_event '{"type": "github.pr.anaconda", "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://cobra02/users/rv/s2/webui-zveleba-f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        #run_event '{"type": "github.pr.anaconda", "test": {"testplans": "Anaconda WebUI plugin plan 1"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        ;;
    webui-zdenek-cobra-test)
        ./pipeline \
        --debug-log permian.log \
        --override workflows.dry_run=False \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/anaconda-permian/ui/webui/test/integration \
        --override AnacondaWebUI.anaconda_repo=file:///home/rvykydal/work/git/rvykydal/anaconda-permian \
        run_event '{"type": "github.pr.anaconda", "test": {"testplans": "WebUI Integration all"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://cobra02/users/rv/s2/webui-zveleba-f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        #run_event '{"type": "github.pr.anaconda", "test": {"testplans": "Anaconda WebUI plugin plan 1"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        ;;
    webui-zdenek-cobra-test-rv)
        ./pipeline \
        --debug-log permian.log \
        --override workflows.dry_run=False \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/anaconda-permian/ui/webui/test/integration \
        --override AnacondaWebUI.anaconda_repo=file:///home/rvykydal/work/git/rvykydal/anaconda-permian \
        run_event '{"type": "github.pr.anaconda", "test": {"testplans": "WebUI Integration rv"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://cobra02/users/rv/s2/webui-zveleba-f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        #run_event '{"type": "github.pr.anaconda", "test": {"testplans": "Anaconda WebUI plugin plan 1"}, "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        ;;
    webui-permian)
        ./pipeline \
        --debug-log permian.log \
        --override workflows.dry_run=False \
        --override library.directPath=/home/rvykydal/work/git/rvykydal/anaconda-permian/ui/webui/test/integration \
        --override AnacondaWebUI.anaconda_repo=file:///home/rvykydal/work/git/rvykydal/anaconda-permian \
        run_event '{"type": "github.pr.anaconda", "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://cobra02/users/rv/s2/webui-permian", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'
        ;;
#PYTHONPATH=./tplib ./pipeline run_event -d -o "library.directPath=/home/zveleba/temp/anaconda-build-container/data/anaconda/ui/webui/test/integration" -o "AnacondaWebUI.anaconda_repo=file:///home/zveleba/temp/anaconda-build-container/data/anaconda" '{"type": "github.pr.anaconda", "InstallationSource": {"base_repo_id": "bootiso", "repos": {"bootiso": {"x86_64": {"os": "http://file.emea.redhat.com/zveleba/f38", "kernel": "images/pxeboot/vmlinuz", "initrd": "images/pxeboot/initrd.img"}}}}}'


esac
