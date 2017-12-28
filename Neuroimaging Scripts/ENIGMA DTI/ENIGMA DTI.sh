# Create a parent directory that you will work out of:

mkdir ENIGMA/



# Change into your newly created parent directory:

cd ENIGMA/



# Make your sub-directories

mkdir ENIGMA/enigmaDTI
mkdir ENIGMA/enigmaDTI/TBSS
mkdir ENIGMA/enigmaDTI/TBSS/run_tbss
mkdir ENIGMA/enigmaDTI/TBSS/ENIGMA_targets
mkdir ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited



# Download a copy of the ENGIMA-DTI Template FA Map, Edited Skeleton, Masks, and Corresponding Distance Maps from the following url: http://www.fmrib.ox.ac.uk/fsl/tbss/index.html

# You should have the following files:

# ENIGMA_DTI_FA.nii.gz

# ENIGMA_DTI_FA_mask.nii.gz

# ENIGMA_DTI_FA_skeleton.nii.gz

# ENIGMA_DTI_FA_skeleton_mask.nii.gz

# ENIGMA_DTI_FA_skeleton_mask_dst.nii.gz

# Put your downloaded images into the following directory: enigmaDTI/TBSS/ENIGMA_targets using the mv command

mv ENIGMA_DTI_FA.nii.gz ENIGMA/enigmaDTI/TBSS/ENIGMA_targets
mv ENIGMA_DTI_FA_mask.nii.gz ENIGMA/enigmaDTI/TBSS/ENIGMA_targets
mv ENIGMA_DTI_FA_skeleton.nii.gz ENIGMA/enigmaDTI/TBSS/ENIGMA_targets
mv ENIGMA_DTI_FA_skeleton_mask.nii.gz ENIGMA/enigmaDTI/TBSS/ENIGMA_targets
mv ENIGMA_DTI_FA_skeleton_mask_dst.nii.gz ENIGMA/enigmaDTI/TBSS/ENIGMA_targets



# Copy your files over using the CP command into the enigmaDTI/TBSS/run_tbss command
# cp <FILE NAME> enigmaDTI/TBSS/run_tbss/



# Change into enigmaDTI/TBSS/run_tbss/

cd enigmaDTI/TBSS/run_tbss



# Make sure that you have the correct module loaded:

module purge
module load fsl/5.0.9



# Use the following command where you will erode the images slightly with FSL, which will create ./FA folder with all of the subjects’ eroded images and it will place all of the original images in a ./origdata folder. If you are running your command individually make sure to include qsub -cwd -q som,asom,pub*,free* before your command:

/data/apps/fsl/5.0.9/bin/tbss_1_preproc *nii.gz



# Register all of your subjects to the template. You can change the registration method if a better method exists for your data. If you are running your commands individually make sure to include qsub -cwd -q som,asom,pub*,free* before your commands:


/data/apps/fsl/5.0.9/bin/tbss_2_reg -t ENIGMA_DTI_FA.nii.gz
/data/apps/fsl/5.0.9/bin/tbss_3_postreg -S



# Quality Control your images to ensure that you have good registration. This can be done using commands like slices followed by the file name for a quick and painless look at your images.

# If any maps have registered poorly use the following commands:

# mkdir ENIGMA/enigmaDTI/TBSS/run_tbss/BAD_REGISTER/
# mv <BAD REGISTER FILE NAME> ENIGMA/enigmaDTI/TBSS/run_tbss/BAD_REGISTER/



# Use FSL to create FA.nii.gz files. In this you will be creating a common mask for the specific study and it will be saved as ENIGMA/enigmaDTI/TBSS?ENIGMA_targets_edited/mean_FA_mask.nii.gz.

/data/apps/fsl/5.0.9/bin/fslmerge -t ./FA ./FA/*FA_to_target.nii.gz
/data/apps/fsl/5.0.9/bin/fslmaths FA.nii.gz -bin -Tmean –thr 0.9 /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz



# Mask and rename the ENIGMA DTI Templates to get new files for running TBSS. If you are running your commands individually make sure to include qsub -cwd -q som,asom,pub*,free* before your commands:

/data/apps/fsl/5.0.9/bin/fslmaths /enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA.nii.gz –mas /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA.nii.gz

/data/apps/fsl/5.0.9/bin/fslmaths /enigmaDTI/TBSS/ENIGMA_targets/ENIGMA_DTI_FA_skeleton.nii.gz –mas /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz /enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton.nii.gz



# Check to make sure that your folder now contains the following:

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA.nii.gz

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton.nii.gz



# Make sure that you are in the directory where you have the newly masked ENIGMA Target and Skeleton to create a Distance Map. The Distance Map will be created but the function will return an error because the all_FA is not included here. The skeleton has already been thresholded here so we do not need to select a higher FA value to threshold, though it may change for your particular data. If you are running your commands individually make sure to include qsub -cwd -q som,asom,pub*,free* before your commands:

/data/apps/fsl/5.0.9/bin/tbss_4_prestats -0.049



# This should output ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton_mask_dst



# Your folder should now contain the following:

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA.nii.gz

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_mask.nii.gz

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton.nii.gz

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton_mask.nii.gz

# ENIGMA/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton_mask_dst.nii.gz



# Change back into your run_tbss folder:

cd ENIGMA/enigmaDTI/TBSS/run_tbss/



# Run your processing in parallel to save time if necessary. This moves each subject FA image into its own directory. If you are submitting this as a script, make sure to include qsub -cwd -q som,asom,pub*,free* before your commands:

for subj in `ls FA/ecc_1*FA_FA.nii.gz | awk -F/ ' { print $2 } ' | awk -F_p ' { print $1 } '`; do 
 mkdir -p ./FA_individ/${subj}/stats/
 mkdir -p ./FA_individ/${subj}/FA/
 cp -f ./FA/${subj}_*.nii.gz ./FA_individ/${subj}/FA/

 ####[optional/recommended]####

 /data/apps/fsl/5.0.9/binfslmaths ./FA_individ/${subj}/FA/${subj}_*FA_to_target.nii.gz -mas ../ENIGMA_targets_edited/mean_FA_mask.nii.gz ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz

done



# Skeletonize the images by projecting the ENIGMA skeleton onto them. If you are submitting this as a script, make sure to include qsub -cwd -q som,asom,pub*,free* before your commands:

for subj in `ls FA/ecc_1*FA_FA.nii.gz | awk -F/ ' { print $2 } ' | awk -F_p ' { print $1 } '`; do 

    /data/apps/fsl/5.0.9/bin/tbss_skeleton -i ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz -p 0.049 {HPC}enigma_DTI/maastricht/nifti/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton_mask_dst.nii.gz /data/apps/fsl/5.0.9/data/standard/LowerCingulum_1mm.nii.gz ./FA_individ/${subj}/FA/${subj}_masked_FA.nii.gz ./FA_individ/${subj}/stats/${subj}_masked_FAskel.nii.gz -s {HPC}enigma_DTI/maastricht/nifti/enigmaDTI/TBSS/ENIGMA_targets_edited/mean_FA_skeleton_mask.nii.gz    

done
