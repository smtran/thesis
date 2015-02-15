#!/bin/bash
#
#
#Script to run Stephen's bwFnirtBot.sh script to skull strip anatomic images using bet parameters -f 0.35 -B
#Created 02/10/2015
#
#

for blind in 10 12 14 20 21 22 23 25 27 28 29 31 33 35 36 38 39 41 44 46 49 52 53 55 56 58 62 65 66 67 70 74 76 79; do

	bwFnirtBot.sh \
	-t /data/birc/Atlanta/tranThesis/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/MA0${blind}/sessA/T1/MA0${blind}_MNI.nii.gz \
	-s betMA0${blind} \
	-o /data/birc/Atlanta/tranThesis/03.derivedData/brainExtractT1_${blind} \

done
