#!/bin/sh


outdirFinalROI=/netusers/stran5/gitRepos/thesis/regions/FinalROI

mkdir -p $outdirFinalROI

outdirTempROI=/netusers/stran5/gitRepos/thesis/regions/TempROI

mkdir -p $outdirTempROI

outdirAtlasExtraction=/netusers/stran5/gitRepos/thesis/regions/AtlasExtraction

mkdir -p $outdirAtlasExtraction 

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

