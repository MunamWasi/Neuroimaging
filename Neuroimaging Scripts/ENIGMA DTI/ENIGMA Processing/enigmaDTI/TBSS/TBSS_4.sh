#!/bin/bash
#$ -N FA_subid
#$ -q som,asom,pub*,free*
#$ -l h_rt=70:00:00 #40 hour run
#$ -cwd

module load fsl/5.0.9

cd /dfs1/som/tvanerp_col/enigma_DTI/maastricht/nifti/enigmaDTI/TBSS/ENIGMA_targets_edited
tbss_4_prestats -0.049


