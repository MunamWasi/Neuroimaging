
#$ 1200_ENIGMA_DTI
#$ -S /bin/bash
#$ -q 
#$ -cwd
#$ -o 1200_ENIGMA_DTI.out
#$ -e 1200_ENIGMA_DTI.err

module load fsl/5.0.9

for d in `ls | grep ^1200_` ; do
	tbss_1_preproc *.nii.gz
	tbss_2_reg -t ENIGMA_DTI_FA.nii.gz
	tbss_3_postreg -S
done

