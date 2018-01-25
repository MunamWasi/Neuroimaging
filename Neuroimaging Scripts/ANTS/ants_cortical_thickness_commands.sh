#!/bin/bash
DATA_DIR=${PWD}
TEMPLATE_DIR=${DATA_DIR}/Template/
OUT_DIR=${DATA_DIR}/OutputT1Only/

ANTSPATH=${PWD}/

bash ${ANTSPATH}antsCorticalThickness.sh -d 2 \
  -a ${DATA_DIR}/IXI002-Guys-0828-T1_slice90.nii.gz \
  -e ${TEMPLATE_DIR}template_slice80.nii.gz \
  -m ${TEMPLATE_DIR}template_cerebrum_mask_slice80.nii.gz \
  -p ${TEMPLATE_DIR}prior%d_slice80.nii.gz \
  -o ${OUT_DIR}example

