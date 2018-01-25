
# I am excluding the first case as I ran that one with a -NOQ -MT 9 option
#subids=`ls -d 0009*`
subids=`ls -d1 005* | grep -v 0050002` # head -1`
curdir=`pwd`

mkdir bet_T1_qsub_files

for subid in ${subids}; do
 echo $subid
 cat bet_T1_template.sh | sed s/subid/${subid}/g > bet_T1_qsub_files/${subid}_bet_T1.sh
 cd ${curdir}/bet_T1_qsub_files
    qsub ${subid}_bet_T1.sh
 cd ${curdir}
done