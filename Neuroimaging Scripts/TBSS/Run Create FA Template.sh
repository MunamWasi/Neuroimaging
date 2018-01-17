#!/bin/sh

#subids=`ls -d nifti_f25/000* | awk -F/ ' { print $NF } ' | head -1`
subids = SUBIDS

echo $subids
mkdir create_FA_qsub_files_f25
curdir=`pwd`

for subid in ${subids}; do
 sed s/subid/${subid}/g 00_create_FA_template_f25.sh > create_FA_qsub_files_f25/${subid}_00_create_FA_f25.sh
 cd create_FA_qsub_files_f25
 pwd
 qsub ${subid}_00_create_FA_f25.sh
 cd ${curdir} 
 pwd
done

