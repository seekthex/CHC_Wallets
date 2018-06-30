#!/bin/bash
in=/autofs/cluster/transcend/mega/scripts/
insub=/autofs/cluster/transcend/mega/dtn/20141015/123
out=/autofs/cluster/transcend/mega/scripts/1256

for i in $(cat $in/list_subjects.txt); do
echo "$i"
mkdir ${insub}/${i}/file.nii.gz -k ${insub}/${i}/rh.nii.gz -M

wait
done
