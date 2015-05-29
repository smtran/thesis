#!/bin/sh

  
#outdirFinalROes the parent dir of the thesis repo?
# ...stella's VM: /home/brain/gitRepos
#....stella's qball3: /data/birc/Atlanta/tranThesis/gitRepos


repoParent="/data/birc/Atlanta/tranThesis/gitRepos"

#modified regions of the H-O atlas or regions created (i.e., hand bump)
inputDir="${repoParent}/thesis/regions/modifiedRegions"

#masks that will be used to extract residual time series
outdirFinalROI="${repoParent}/thesis/regions/FinalROI"

#masks (nonbinary) that will be used to visually inspect boundaries
outdirTempROI="${repoParent}/thesis/regions/TempROI"

#regions extracted from lateralized H-O atlas 
outdirAtlasExtraction="${repoParent}/thesis/regions/AtlasExtraction"



################ Posterior Language: Posterior Perisylvian Regions ################

#Regions from LATERALIZED HO Cortical Atlas
#41 L Angular Gyrus
#42 R Angular Gyrus
#39 L Supramarginal Gyrus, posterior division
#40 R Supramarginal Gyrus, posterior division
#37 L Supramarginal Gyrus, anterior division
#38 R Supramarginal Gyrus, anterior division
#19 L Superior Temporal Gyrus, posterior division
#20 R Superior Temporal Gyrus, posterior division
#25 L Middle Temporal Gyrus, temporoccipital part
#26 R Middle Temporal Gyrus, temporoccipital part
#91 L Planum Temporale
#92 R Planum Temporale

#left middle temporal gyrus, temporoocciptal part
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 25 -uthr 25 -bin \
${outdirAtlasExtraction}/LH-MTGtempoccip-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 25 -uthr 25 \
${outdirAtlasExtraction}/LH-MTGtempoccip-mask-orig.nii.gz \
-odt char

#right middle temporal gyrus, temporoocciptal part
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 26 -uthr 26 -bin \
${outdirAtlasExtraction}/RH-MTGtempoccip-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 26 -uthr 26 \
${outdirAtlasExtraction}/RH-MTGtempoccip-mask-orig.nii.gz \
-odt char


#left angular gyrus
fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 41 -uthr 41 -bin \
${outdirAtlasExtraction}/LH-Ang-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 41 -uthr 41 \
${outdirAtlasExtraction}/LH-Ang-mask-orig.nii.gz \
-odt char

#right angular gyrus
fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 42 -uthr 42 -bin \
${outdirAtlasExtraction}/RH-Ang-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 42 -uthr 42 \
${outdirAtlasExtraction}/RH-Ang-mask-orig.nii.gz \
-odt char

#left supramarginal gyrus, posterior division
fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 39 -uthr 39 -bin \
${outdirAtlasExtraction}/LH-Supram-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 39 -uthr 39 \
${outdirAtlasExtraction}/LH-Supram-mask-orig.nii.gz \
-odt char

#right supramarginal gyrus, posterior division
fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 40 -uthr 40 -bin \
${outdirAtlasExtraction}/RH-Supram-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 40 -uthr 40 \
${outdirAtlasExtraction}/RH-Supram-mask-orig.nii.gz \
-odt char

#left supramarginal gyrus, anterior division
fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 37 -uthr 37 -bin \
${outdirAtlasExtraction}/LH-SupramAnt-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 37 -uthr 37 \
${outdirAtlasExtraction}/LH-SupramAnt-mask-orig.nii.gz \
-odt char

#right supramarginal gyrus, anterior division
fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 38 -uthr 38 -bin \
${outdirAtlasExtraction}/RH-SupramAnt-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedAngularSupramarginal.nii.gz \
-thr 38 -uthr 38 \
${outdirAtlasExtraction}/RH-SupramAnt-mask-orig.nii.gz \
-odt char


#left superior temporal gyrus, posterior division
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 19 -uthr 19 -bin \
${outdirAtlasExtraction}/LH-STG-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 19 -uthr 19 \
${outdirAtlasExtraction}/LH-STG-mask-orig.nii.gz \
-odt char

#right superior temporal gyrus, posterior division
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 20 -uthr 20 -bin \
${outdirAtlasExtraction}/RH-STG-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 20 -uthr 20 \
${outdirAtlasExtraction}/RH-STG-mask-orig.nii.gz \
-odt char

#left planum temporale
fslmaths \
${inputDir}/cortl_slicedPlanumTemp.nii.gz \
-thr 91 -uthr 91 -bin \
${outdirAtlasExtraction}/LH-PlanumTemp-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedPlanumTemp.nii.gz \
-thr 91 -uthr 91 \
${outdirAtlasExtraction}/LH-PlanumTemp-mask-orig.nii.gz \
-odt char

#right planum temporale
fslmaths \
${inputDir}/cortl_slicedPlanumTemp.nii.gz \
-thr 92 -uthr 92 -bin \
${outdirAtlasExtraction}/RH-PlanumTemp-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedPlanumTemp.nii.gz \
-thr 92 -uthr 92 \
${outdirAtlasExtraction}/RH-PlanumTemp-mask-orig.nii.gz \
-odt char


#create subset for visualization in fslview and decisions about boundaries
fslmaths ${outdirAtlasExtraction}/LH-Ang-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-Ang-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-Supram-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-Supram-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-SupramAnt-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-SupramAnt-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-STG-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-STG-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-MTGtempoccip-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-MTGtempoccip-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-PlanumTemp-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-PlanumTemp-mask-orig.nii.gz \
${outdirTempROI}/posteriorLanguageROIs.nii.gz

#create binarized mask to extract residuals for each hemisphere
fslmaths ${outdirAtlasExtraction}/LH-Ang-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-Supram-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-SupramAnt-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-STG-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-MTGtempoccip-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-PlanumTemp-mask-bin.nii.gz \
${outdirFinalROI}/LH-posteriorLanguage-mask-bin.nii.gz

fslmaths ${outdirAtlasExtraction}/RH-Ang-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-Supram-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-SupramAnt-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-STG-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-MTGtempoccip-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-PlanumTemp-mask-bin.nii.gz \
${outdirFinalROI}/RH-posteriorLanguage-mask-bin.nii.gz
