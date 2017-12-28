#!/bin/bash

#$ -N FA_subid          
#$ -S /bin/bash         
#$ -q som,asom,pub*,free*
#$ -l h_rt=70:00:00
#$ -cwd

module load fsl/5.0.9

# directory with nifti format dti data + bvec and bval created by converting DICOM data using dcm2nii
# modify sample dir below
sample_dir=/dfs1/som/tvanerp_col/enigma_DTI/maastricht/nifti
scripts_dir=/dfs1/som/tvanerp_col/scripts_tbss

# 1. eddy current (motion) correction
#echo "1. eddy current (motion) correction"
/data/apps/fsl/5.0.9/bin/eddy_correct ${sample_dir}/subid/subid.nii.gz ${sample_dir}/subid/ecc_subid 0

#echo "2. correct bvec file for eddy current (motion) correction - translation & rotation"
# 2. correct bvec file for eddy current (motion) correction - translation & rotation
cd ${sample_dir}/subid
${scripts_dir}/ecclog2mat.sh ./ecc_subid.ecclog
${scripts_dir}/rotbvecs subid.bvec ecc_subid.bvec mat.list
cp -f subid.bval ecc_subid.bval 
# create mask from first b=0 image
/data/apps/fsl/5.0.9/bin/fslroi ecc_subid.nii.gz ecc_ref 0 1
# The b_ecc_ref_f25 images are used for visual QA
/data/apps/fsl/5.0.9/bin/bet ecc_ref b_ecc_ref_f25 -f .25
# The b_ecc_ref_f25 images sometimes have small holes (brain mask is not filled).
# We can correct this using fslmaths with the -fillh option
/data/apps/fsl/5.0.9/bin/fslmaths b_ecc_ref_f25 -fillh b_fillh_ecc_ref_f25

echo "3. dtifit"
# 3. dtifit 
#/data/apps/fsl/5.0.9/bin/dtifit --data=${sample_dir}/subid/ecc_subid_dti.nii.gz --out=${sample_dir}/subid/ecc_subid_dti_f25 --mask=${sample_dir}/subid/b_ecc_ref_f25.nii.gz --bvecs=${sample_dir}/subid/ecc_subid_dti.bvec --bvals=${sample_dir}/subid/ecc_subid_dti.bval
# replaced the b_ecc_ref with the b_fillh_ecc_ref to avoid missing voxes in the brain mask
/data/apps/fsl/5.0.9/bin/dtifit --data=${sample_dir}/subid/ecc_subid.nii.gz --out=${sample_dir}/subid/ecc_subid_f25 --mask=${sample_dir}/subid/b_fillh_ecc_ref_f25.nii.gz --bvecs=${sample_dir}/subid/ecc_subid.bvec --bvals=${sample_dir}/subid/ecc_subid.bval

