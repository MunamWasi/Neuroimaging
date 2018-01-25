#!/bin/bash
#$ -N m_subid
#$ -q ctnl,steven,som,asom,pub64,free64
#$ -l h_rt=70:00:00 #40 hour run
#$ -ckpt blcr
#$ -l kernel=blcr
#$ -r y
#$ -pe openmp 6-8
#$ -cwd

module load AutoSeg/3.3.2
module load mass
module load afni/2011_12_21_1014

# define the project directory
#pdir=/pub/tvanerp/otsuka/analysis/level1
pdir=/dfs1/som/tvanerp_col/abide/t1/fslvbm

# run N4 bias field correction
/data/apps/AutoSeg/3.3.2/bin/N4ITKBiasFieldCorrection ${pdir}/subid/mprage.nii.gz ${pdir}/subid/n4_subid.nii

#cd ${pdir}/subid/T1
#mkdir ${pdir}/subid/mask

if [ -d ${pdir}/mass_log_files ]; then
  echo ${pdir}/mass_log_files exists ...
else mkdir ${pdir}/mass_log_files
fi

# run mass to obtain a brain mask for the T1 and allow for 6 cores per mass job
/data/apps/mass/1.1.0/bin/mass -in ${pdir}/subid/n4_subid.nii -dest ${pdir}/subid/mask -log ${pdir}/mass_log_files -NOQ -MT $CORES
#/data/apps/mass/1.1.0/bin/mass -in ${pdir}/n4_subid.nii -dest ${pdir}/subid/mask -log ${pdir}/mass_log_files