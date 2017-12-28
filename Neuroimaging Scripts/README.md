# Neuroimaging Scripts

ENIGMA DTI
This repository is meant to document scripts used for ENIGMA DTI processing. It will be a continuous work in progress.

Repository Contents
ENIGMA Processing
ENIGMA DTI Template FA Map
Pipeline Workthrough
Pre-Requisites
FSL Software
FSL Download and Installation information can be found at this url: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation

Motion/Eddy Correction
Placeholder

Masking
Placeholder

Tensor Calculation
Placeholder

Creation of FA Maps
Placeholder

Quality Control
Placeholder

Module Load:
FSL/5.0.9

FSL Version 5.0.9 was used for this project. Other versions are available. Commands might differ slightly.

ENIGMA DTI Targets
You can find these at the following url: http://enigma.ini.usc.edu/wp-content/uploads/2013/02/enigmaDTI.zip

You should be able to extract the following files:

ENIGMA_DTI_FA.nii.gz
ENIGMA_DTI_FA_mask.nii.gz
ENIGMA_DTI_FA_skeleton.nii.gz
ENIGMA_DTI_FA_skeleton_mask.nii.gz
ENIGMA_DTI_FA_skeleton_mask_dst.nii.gz
File Structure:
enigmaDTI TBSS run_tbss ENIGMA_targets ENIGMA_targets_edited [FIX THIS]

$ mkdir TBSS

$ mkdir TBSS/run_tbss

$ mkdir TBSS/ENIGMA_targets

$ mdkir TBSS/ENIGMA_targets_edited

Commands:
Step 1:
Place your downloaded files into the folder entitled /enigmaDTI/TBSS/ENIGMA_targets/.

Step 2:
Copy all of your FA images into your subject folder.

$ cp /subject*_folder/subject*_FA.nii.gz /enigmaDTI/TBSS/run_tbss/

Step 3:
Erode your FA images using FSL.

cd /enigmaDTI/TBSS/run_tbss/

/fsl/5.0.9/bin/tbss_1_preproc *nii.gz

This will create the following folders:

[FOLDERS]

Your current file structure should look like this:

[FILE STRUCTURE]

Step 4:
Register your subjects to your template:

/fsl/5.0.9/bin/tbss_2_reg -t ENIGMA_DTI_FA.nii.gz

/fsl/5.0.9/bin/tbss_3_postreg -S

Quality Control:
[PLACEHOLDER - slices, fslview, slicesdir]

Step 5:
=============================================================

mkdir TBSS mkdir TBSS/run_tbss

cp 1*/FAnii.gz TBSS/run_tbss &

cd TBSS/run_tbss

module load fsl/5.0.9

qsub -cwd -q som,asom,pub*,free* /data/apps/fsl/5.0.9/bin/tbss_1_preproc nii.gz qsub -cwd -q som,asom,pub,free* /data/apps/fsl/5.0.9/bin/tbss_2_reg -t ENIGMA_DTI_FA.nii.gz qsub -cwd -q som,asom,pub*,free* /data/apps/fsl/5.0.9/bin/tbss_3_postreg -S

mkdir /TBSS/ENIGMA_targets_edited/

cd /enigmaDTI/TBSS/run_tbss/

fslmerge -t FA ./FA/*FA_to_target.nii.gz --> Creates FA.nii.gz

fslmaths FA.nii.gz -bin -Tmean –thr 0.9 /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz fslmaths /enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA.nii.gz –mas /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA.nii.gz fslmaths /enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA_skeleton.nii.gz –mas /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton.nii.gz

Step 6:
tbss_4_prestats -0.049

Step 7:
#cd /enigmaDTI/TBSS/run_tbss/

for subj in ls FA/ecc_1*FA_FA.nii.gz | awk -F/ ' { print $2 } ' | awk -F_p ' { print $1 } '; do mkdir -p ./FA_individ/${subj}/stats/ mkdir -p ./FA_individ/${subj}/FA/ cp -f ./FA/${subj}*.nii.gz ./FA_individ/${subj}/FA/ ####[optional/recommended]#### fslmaths ./FA_individ/${subj}/FA/${subj}*FA_to_target.nii.gz -mas ../ENIGMA_targets_edited/mean_FA_mask.nii.gz ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz

done

Step 8:
#cd /enigmaDTI/TBSS/run_tbss/

for subj in ``ls FA/ecc_1*FA_FA.nii.gz | awk -F/ ' { print $2 } ' | awk -F_p ' { print $1 } '``; do

/data/apps/fsl/5.0.9/bin/tbss_skeleton -i ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz -p 0.049 /dfs1/som/tvanerp_col/enigma_DTI/maastricht/nifti/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton_mask_dst.nii.gz /data/apps/fsl/5.0.9/data/standard/LowerCingulum_1mm.nii.gz ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz ./FA_individ/${subj}/stats/${subj}_masked_FAskel.nii.gz -s /dfs1/som/tvanerp_col/enigma_DTI/maastricht/nifti/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton_mask.nii.gz    
done

Pipeline Explanation
Commands:
Step 1:
Placeholder

Step 2:
Placeholder

Step 3:
Placeholder

Step 4:
Placeholder

Step 5:
Placeholder

Step 6:
Placeholder

Step 7:
Placeholder

Step 8:
Placeholder

