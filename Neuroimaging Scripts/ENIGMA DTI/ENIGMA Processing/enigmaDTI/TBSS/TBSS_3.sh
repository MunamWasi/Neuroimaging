#!/bin/bash
#$ -N FA_subid
#$ -q som,asom,pub*,free*
#$ -l h_rt=70:00:00 #40 hour run
#$ -cwd

module load fsl/5.0.9

cd /dfs1/som/tvanerp_col/enigma_DTI/maastricht/nifti/Interactive_ENIGMA/TBSS/run_tbss
tbss_3_postreg -S

