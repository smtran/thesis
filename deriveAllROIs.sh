#!/bin/sh


outdirFinalROI=/home/brain/gitRepos/thesis/regions/FinalROI

mkdir -p $outdirFinalROI

outdirTempROI=/home/brain/gitRepos/thesis/regions/TempROI

mkdir -p $outdirTempROI

outdirAtlasExtraction=/home/brain/gitRepos/thesis/regions/AtlasExtraction

mkdir -p $outdirAtlasExtraction 



################## Posterior Attention: Posterior Cinglulate/Precuneus ############

#Regions from LATERALIZED (cortl) H0 Cortical Atlas 
#61 L Precuneus cortex
#59 L Cingulate gyrus, posterior division
#62 R Precuneus cortex
#60 R Cingulate gyrus, posterior division

#creating one file per exisiting region

#left precuneus
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 61 -uthr 61 -bin \
${outdirAtlasExtraction}/LH-Precu-mask-bin.nii.gz \
-odt char 

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 61 -uthr 61 \
${outdirAtlasExtraction}/LH-Precu-mask-orig.nii.gz \
-odt char 

#left cingulate gyrus
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 59 -uthr 59 -bin \
${outdirAtlasExtraction}/LH-CingulatePosterior-mask-bin.nii.gz \
-odt char 

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 59 -uthr 59 \
${outdirAtlasExtraction}/LH-CingulatePosterior-mask-orig.nii.gz \
-odt char 

#right precuneus
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 62 -uthr 62 -bin \
${outdirAtlasExtraction}/RH-Precu-mask-bin.nii.gz \
-odt char 

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 62 -uthr 62 \
${outdirAtlasExtraction}/RH-Precu-mask-orig.nii.gz \
-odt char 

#right cingulate gyrus
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 60 -uthr 60 -bin \
${outdirAtlasExtraction}/RH-CingulatePosterior-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 60 -uthr 60 \
${outdirAtlasExtraction}/RH-CingulatePosterior-mask-orig.nii.gz \
-odt char

#create subset for visualization in fslview and decisions about boundaries
fslmaths ${outdirAtlasExtraction}/LH-Precu-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-CingulatePosterior-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-Precu-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-CingulatePosterior-mask-orig.nii.gz \
 ${outdirTempROI}/posteriorAttentionROIs.nii.gz

#use fslview to visual gyral and sulcal boundaries post atten ROI


################ Posterior Language: Posterior Perisylvian Regions #############

#Regions from LATERALIZED HO Cortical Atlas
#41 L Angular Gyrus
#42 R Angular Gyrus
#39 L Supramarginal Gyrus, posterior division
#40 R Supramarginal Gyrus, posterior division
#19 L Superior Temporal Gyrus, posterior division
#20 R Superior Temporal Gyrus, posterior division
#25 L Middle Temporal Gyrus, temporooccipital part
#26 R Middle Temporal Gyrus, temporooccipital part

#creating one file per existing region

#left angular gyrus
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 41 -uthr 41 -bin \
${outdirAtlasExtraction}/LH-Ang-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 41 -uthr 41 \
${outdirAtlasExtraction}/LH-Ang-mask-orig.nii.gz \
-odt char

#right angular gyrus
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 42 -uthr 42 -bin \
${outdirAtlasExtraction}/RH-Ang-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 42 -uthr 42 \
${outdirAtlasExtraction}/RH-Ang-mask-orig.nii.gz \
-odt char

#left supramarginal gyrus, posterior division
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 39 -uthr 39 -bin \
${outdirAtlasExtraction}/LH-Supram-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 39 -uthr 39 \
${outdirAtlasExtraction}/LH-Supram-mask-orig.nii.gz \
-odt char

#right supramarginal gyrus, posterior division
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 40 -uthr 40 -bin \
${outdirAtlasExtraction}/RH-Supram-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 40 -uthr 40 \
${outdirAtlasExtraction}/RH-Supram-mask-orig.nii.gz \
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

#left middle temporal gyrus, temporoocciptal part
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 25 -uthr 25 -bin \
${outdirAtlasExtraction}/LH-MTG-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 25 -uthr 25 \
${outdirAtlasExtraction}/LH-MTG-mask-orig.nii.gz \
-odt char

#right middle temporal gyrus, temporoocciptal part
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 26 -uthr 26 -bin \
${outdirAtlasExtraction}/RH-MTG-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 26 -uthr 26 \
${outdirAtlasExtraction}/RH-MTG-mask-orig.nii.gz \
-odt char

#left middle temporal gyrus, posterior division 
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 23 -uthr 23 -bin \
${outdirAtlasExtraction}/LH-MTGpost-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 23 -uthr 23 \
${outdirAtlasExtraction}/LH-MTGpost-mask-orig.nii.gz \
-odt char

#right middle temporal gyrus, posterior division
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 24 -uthr 24 -bin \
${outdirAtlasExtraction}/RH-MTGpost-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 24 -uthr 24 \
${outdirAtlasExtraction}/RH-MTGpost-mask-orig.nii.gz \
-odt char

#create subset for visualization in fslview and decisions about boundaries
fslmaths ${outdirAtlasExtraction}/LH-Ang-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-Ang-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-Supram-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-Supram-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-STG-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-STG-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-MTG-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-MTG-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-MTGpost-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-MTGpost-mask-orig.nii.gz \
 ${outdirTempROI}/posteriorLanguageROIs.nii.gz
