#!/bin/sh

set -eu

START_COMMIT="HEAD^"
#END_COMMIT=HEAD
END_COMMIT=$(git rev-parse --abbrev-ref HEAD)

RETVAL=0

PYLINT_ARG="-E "

while getopts ":as:" opt; do
  case $opt in
    a)
      echo "Checking for everything"
      PYLINT_ARG=""
      ;;
    s)
      echo "Checking from commit $OPTARG"
      START_COMMIT=$OPTARG
      ;;
    \?)
      echo "Invalid option -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
  esac
done

git diff --name-only $START_COMMIT > files.txt

while read line
do

  echo "====================== File $line"
  git checkout $START_COMMIT
  pylint $PYLINT_ARG $line | awk 'BEGIN { FS = ":" } ; $1 ~/^[WCREFI]$/ {print $1 $3}' > old.pylint.out || true
  git checkout $END_COMMIT
  pylint $PYLINT_ARG $line | awk 'BEGIN { FS = ":" } ; $1 ~/^[WCREFI]$/ {print $1 $3}' > new.pylint.out || true
  diff old.pylint.out new.pylint.out || RETVAL=1

done < files.txt

rm ./files.txt
#rm ./old.pylint.out
#rm ./new.pylint.out

if [ $RETVAL == "1" ]; then
  echo !!!!!!!!!!!!!!!!!!!!!!!!!!! OMG !!! FAILED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
fi
