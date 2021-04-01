#!/bin/sh

#set -x

machine="test"
mac=""
target="default"
update="yes"
default="yes"
bootopts=""
edit="no"
infer_target="yes"

pxecfg_dir="/var/lib/tftpboot/linux-install/pxelinux.cfg"
machine_dir="${pxecfg_dir}/users.cfg/rv/machines"
images_subdir="test/users/rv/scripted"
images_dir="/var/lib/tftpboot/linux-install/${images_subdir}"

while getopts ":dxt:m:b:e" opt; do
  case $opt in
    d)
      echo "-d - do not set as default target"
      default="no"
      ;;
    e)
      echo "-e - just edit the pxe config file"
      edit="yes"
      ;;
    x)
      echo "-x - do not update existing target"
      update="no"
      ;;
    t)
      echo "-t $OPTARG - pxe target"
      infer_target="no"
      target=$OPTARG
      ;;
    m)
      echo "-m $OPTARG - machine ID or MAC"
      machine=$OPTARG
      ;;
    b)
      echo "-b "$OPTARG" - boot options for new target"
      bootopts="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

if [[ $# -lt 1 && "${edit}" == "no" ]]; then
  echo "Usage: $0 [OPTIONS] <INSTALL_TREE_URL>"
  echo ""
  echo "OPTIONS: -t - pxe target"
  echo "              if not supplied tries to infer compose ID target from url path"
  echo "              if can't infer, default target is \"default\""
  echo "         -m - machine ID or MAC"
  echo "         -d - do not set as default target"
  echo "         -x - do not update existing target"
  echo "         -b - boot options for new target"
  echo "         -e - just edit the pxe config file"
  exit 1
fi

case $machine in
  rv_test)
    mac="52:54:00:9f:21:28"
    ;;
  rv_test2)
    mac="52:54:00:5d:bf:04"
    ;;
  rv_test3)
    mac="52:54:00:12:d8:4f"
    ;;
  *)
    if [[ "$machine" =~ "^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$" ]]; then
      mac=${machine}
    else
      echo "Wrong -m option ${machine}"
      exit 1
    fi
    ;;
esac

# "f4:ce:46:2c:44:7a" -> "01-f4-ce-46-2c-44-7a"
#bash 4
#mac_cfg=${mac,,}
#mac_cfg=01-${mac_cfg//:/-}
mac_cfg=01-$(echo "$mac" | tr '[:upper:]' '[:lower:]' | tr ':' '-')


cfg_file=${machine_dir}/${mac_cfg}
url=$1

if [[ ${infer_target} == "yes" && "$url" =~ "\/([^\/]*)\/compose\/" ]]; then
  target=${BASH_REMATCH[1]}
  echo "Inferred copose id target ${target } from url."
fi

echo "###############################################"
echo "machine : ${machine}"
echo "MAC     : ${mac}"
echo "URL     : ${url}"
echo "target  : ${target}"
echo "cfg     : ${cfg_file}"
echo "default : ${default}"
echo "###############################################"

if [[ ! -e ${cfg_file} ]]; then
  echo "Creating new ${cfg_file}"

  cat << EOF > ${cfg_file}
DEFAULT ${target}
# ${mac_cfg}
INCLUDE pxelinux.cfg/return.menu
EOF

fi

if [[ $edit == "yes" ]]; then
  vim ${cfg_file}
  echo "Edited the file ${cfg_file}"
  exit 0
fi

egrep -q '^label '${target}'$' ${cfg_file}
if [[ $? == 0 ]]; then
  if [[ "${update}" == "yes" ]]; then
    echo "Target exists, updating repo="
    sed -i -e "/[[:space:]]*append initrd=.*\/${target}\/initrd.img/ s|repo=[^[:space:]]*|repo=${url}|" ${cfg_file}
  else
    echo "Target exists, exiting."
    exit 0
  fi
else
  echo "Target does not exist, creating it."
  cat << EOF >> ${cfg_file}

label ${target}
  menu label ${target}
  kernel ${images_subdir}/${target}/vmlinuz
  append initrd=${images_subdir}/${target}/initrd.img repo=${url} ${bootopts}
EOF
fi

target_images_dir=${images_dir}/${target}
if [[ ! -d ${target_images_dir} ]]; then
  echo "Creating ${target_images_dir}."
  mkdir ${target_images_dir}
fi

echo "Downloading kernel and initrd."
#wget ${url}/images/pxeboot/vmlinuz -O ${target_images_dir}/vmlinuz
#wget ${url}/images/pxeboot/initrd.img -O ${target_images_dir}/initrd.img
curl -L ${url}/images/pxeboot/vmlinuz --output ${target_images_dir}/vmlinuz
curl -L ${url}/images/pxeboot/initrd.img --output ${target_images_dir}/initrd.img

if [[ ${default} == "yes" ]]; then
  echo "Setting as default target."
  sed -i -e "/^DEFAULT/ s|.*|DEFAULT ${target}|" ${cfg_file}
fi

echo ${cfg_file}
egrep '^DEFAULT' ${cfg_file}

symlink_file=${pxecfg_dir}/${mac_cfg}
if [[ -e ${symlink_file} ]]; then
  echo "WARNING: File ${symlink_file} exists, should be a symlink!"
else
  if [[ ! -L ${symlink_file} ]]; then
    echo "Creating symlink ${symlink_file}"
    ln -s ./users.cfg/rv/machines/${mac_cfg}  ${symlink_file}
  fi
fi

