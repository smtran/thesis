#!/bin/sh

#script to extract all voxel F-stat values in an ROI. 

parentDir="/data/birc/Atlanta/tranThesis/03.derivedData"


#for anterior language region
for blind in 10; do

	3dmaskdump \
	-mask ${parentDir}/analysis1_prelimLangLit/backtransformedROIs/MA0${blind}_bwFnirtBotOutput/inNativeSpaceOfEPI/LH-anteriorLanguage-mask-bin+mni2func.nii.gz \
	-noijk \
	-nozero \
	-o ${parentDir}/analysis2_topPercentVoxelsInROI/01.fStatROImaskValues/MA0${blind}_LH-anteriorLanguage_fStatROImaskValues
	${parentDir}/applyGLM/batch-20150313173303/results.MA0${blind}.language.onsetsBlock/stats.MA0${blind}.language.onsetsBlock_REML+orig[1]

done


#for posterior language region
for blind in 10; do

	3dmaskdump \
	-mask ${parentDir}/analysis1_prelimLangLit/backtransformedROIs/MA0${blind}_bwFnirtBotOutput/inNativeSpaceOfEPI/LH-posteriorLanguage-mask-bin+mni2func.nii.gz \
	-noijk \
	-nozero \
	-o ${parentDir}/analysis2_topPercentVoxelsInROI/01.fStatROImaskValues/MA0${blind}_LH-posteriorLanguage_fStatROImaskValues
	${parentDir}/applyGLM/batch-20150313173303/results.MA0${blind}.language.onsetsBlock/stats.MA0${blind}.language.onsetsBlock_REML+orig[1]


done

