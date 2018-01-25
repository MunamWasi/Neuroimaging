#!/bin/sh

# I am excluding the first case as I ran that one with a -NOQ -MT 6 option
#subids=`ls -d *nii | awk -F. ' { print $1 } ' | grep -v n4`
subids=`ls -d 00?????` #  | head -1`
curdir=`pwd`

mkdir mass_qsub_files

for subid in ${subids}; do
 echo $subid
 cat mass_template.sh | sed s/subid/${subid}/g > mass_qsub_files/${subid}_mass.sh
 cd ${curdir}/mass_qsub_files
    echo qsub ${subid}_mass.sh
    qsub ${subid}_mass.sh
 cd ${curdir}
done