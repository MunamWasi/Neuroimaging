#!/bin/sh

for dir in `ls -dl * | grep drwx  | awk ' { print $NF } ' | grep -v tgz | grep -v sh | grep -v log`; do
 echo $dir
 echo "tar -zcf ${dir}.tgz ${dir} --remove-files"
 tar -zcf ${dir}.tgz ${dir} --remove-files
done