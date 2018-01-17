# get_hip_subfield_volumes_FS6.0.sh

#!/bin/sh

# FS6.0 puts the following files in the freesurfer mri directory
# lh.hippoSfVolumes-T1.v10.txt  rh.hippoSfVolumes-T1.v10.txt

\rm hip_subfield_volumes_FS6.0.csv

for subid in `ls -d1 {SOMETHING}`; do
 cat ${subid}/mri/lh.hippoSfVolumes-T1.v10.txt | sed s/^/"${subid} left "/g | sed s/" "/","/g >> hip_subfield_volumes_FS6.0.csv
 cat ${subid}/mri/rh.hippoSfVolumes-T1.v10.txt | sed s/^/"${subid} right "/g | sed s/" "/","/g >> hip_subfield_volumes_FS6.0.csv
done
