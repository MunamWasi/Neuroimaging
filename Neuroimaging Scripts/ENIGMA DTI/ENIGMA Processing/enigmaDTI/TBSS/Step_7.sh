#!/bin/sh

module load fsl/5.0.9

#cd /enigmaDTI/TBSS/run_tbss/

for subj in `ls FA/ecc_1*FA_FA.nii.gz | awk -F/ ' { print $2 } ' | awk -F_p ' { print $1 } '`; do 
 mkdir -p ./FA_individ/${subj}/stats/
 mkdir -p ./FA_individ/${subj}/FA/
 cp ./FA/${subj}_*.nii.gz ./FA_individ/${subj}/FA/
 ####[optional/recommended]####
 ${FSLPATH}/fslmaths ./FA_individ/${subj}/FA/${subj}_*FA_to_target.nii.gz -mas /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz

done

