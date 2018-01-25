#!/bin/bash

module load fsl/5.0.9
#for x in `cat view_list_new.txt` ; do
#	echo fslview n4_${x}.nii ${x}/mask/n4_${x}_brainmask.nii.gz
#	fslview n4_${x}.nii ${x}/mask/n4_${x}_brainmask.nii.gz -l Yellow -t .5
#done  

if [ -z $1 ]; then
 echo please enter a subject number;
 exit 1
else
  current_subid=$1
  fvalue=45
  if [ $2 ]; then
    fvalue=$2
  fi
  n=`ls -d1 00* | cat -n | grep ${current_subid} | awk ' { print $1 } '`
  nMinOne=`expr $n - 1`
  ntotal=`ls -d1 00* | wc -l`
  n2view=`expr $ntotal - $nMinOne`;

  echo Starting fslview on case: $n
  echo Number of case done: $nMinOne
  echo Total Number of cases: $ntotal
  echo Number of cases to QA: $n2view
fi

  for x in `ls -d1 00????? | tail -${n2view}`; do
    echo ${x} ${fvalue}
    # fslview 0050233/n4_0050233.nii 0050233/mask/n4_0050233_brainmask.nii.gz
    #fslview ${x}/n4_${x}.nii ${x}/mask/n4_${x}_brainmask.nii.gz -t .5
    fslview ${x}/n4_${x}.nii ${x}/b_n4_${x}_f${fvalue}_mask.nii.gz -t .5
  done

fi
  
