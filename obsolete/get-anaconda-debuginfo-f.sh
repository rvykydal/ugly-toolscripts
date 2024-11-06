#!/usr/bin/sh

treeurl="no"

while getopts ":t" opt; do
  case $opt in
    t)
      echo "-t - infer url from tree url URL"
      treeurl="yes"
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


if [ $# -ne 1 ] ; then
    echo "Usage: $0 [OPTIONS] <URL>"
    echo ""
    echo "OPTIONS: -t - infer url from tree url URL"
    exit 1
fi

url=$1

if [[ ${treeurl} == "yes" ]]; then
    url="$(dirname ${url})/debug/tree/Packages/"
fi

echo "### URL: ${url}"

#package=python-debuginfo

#packages="(anaconda|sqlite|python|glade|pygobject3|gobject-introspection|glibc|glibc-common|glib2|gtk3)"
#wget -r -l1 --no-parent --accept-regex '[^-:print:]'${packages}'-debuginfo.*x86_64' -nd ${url}
#rm index.html


wget -r -l1 --no-parent --accept-regex '[^-:print:]anaconda-debuginfo.*x86_64' -nd ${url}/a/
rm index.html
wget -r -l1 --no-parent --accept-regex '[^-:print:]python3-debuginfo.*x86_64' -nd ${url}/p/
rm index.html
#wget -r -l1 --no-parent --accept-regex '[^-:print:]glade-debuginfo.*x86_64' -nd ${url}/g/
#rm index.html
wget -r -l1 --no-parent --accept-regex '[^-:print:]pygobject3-debuginfo.*x86_64' -nd ${url}/p/
rm index.html
wget -r -l1 --no-parent --accept-regex '[^-:print:]gobject-introspection-debuginfo.*x86_64' -nd ${url}/g/
rm index.html
#wget -r -l1 --no-parent --accept-regex '[^-:print:]glibc-debuginfo.*x86_64' -nd ${url}/g/
#rm index.html
#wget -r -l1 --no-parent --accept-regex '[^-:print:]glibc-common-debuginfo.*x86_64' -nd ${url}/g/
#rm index.html
#wget -r -l1 --no-parent --accept-regex '[^-:print:]glib2-debuginfo.*x86_64' -nd ${url}/g/
#rm index.html
#wget -r -l1 --no-parent --accept-regex '[^-:print:]gtk3-debuginfo.*x86_64' -nd ${url}/g/
#rm index.html
wget -r -l1 --no-parent --accept-regex '[^-:print:]libblockdev-debuginfo.*x86_64' -nd ${url}/l/
rm index.html

