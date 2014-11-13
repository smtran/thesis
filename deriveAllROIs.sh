#!/bin/sh

  
#outdirFinalROes the parent dir of the thesis repo?
# ...stella's VM: /home/brain/gitRepos
#....stella's qball3: /data/birc/Atlanta/tranThesis/gitRepos/


repoParent="/data/birc/Atlanta/tranThesis/gitRepos"

#modified regions of the H-O atlas or regions created (i.e., hand bump)
inputDir="${repoParent}/thesis/regions/modifiedRegions"

mkdir -p $inputDir

#masks that will be used to extract residual time series
outdirFinalROI="${repoParent}/thesis/regions/FinalROI"

mkdir -p $outdirFinalROI

#masks (nonbinary) that will be used to visually inspect boundaries
outdirTempROI="${repoParent}/thesis/regions/TempROI"

mkdir -p $outdirTempROI

#regions extracted from H-O atlas or from modified regions of the H-O atlas
outdirAtlasExtraction="${repoParent}/thesis/regions/AtlasExtraction"

mkdir -p $outdirAtlasExtraction


############## Posterior EXEC Attention: Posterior Cinglulate/Precuneus ##########

#Regions from LATERALIZED (cortl) H0 Cortical Atlas 
#61 L Precuneus cortex
#59 L Cingulate gyrus, posterior division
#62 R Precuneus cortex
#60 R Cingulate gyrus, posterior division

#creating one file per exisiting region

#left precuneus
fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
-thr 61 -uthr 61 -bin \
${outdirAtlasExtraction}/LH-Precu-mask-bin.nii.gz \
-odt char 

fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
-thr 61 -uthr 61 \
${outdirAtlasExtraction}/LH-Precu-mask-orig.nii.gz \
-odt char 

#left cingulate gyrus
fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
-thr 59 -uthr 59 -bin \
${outdirAtlasExtraction}/LH-CingulatePosterior-mask-bin.nii.gz \
-odt char 

fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
-thr 59 -uthr 59 \
${outdirAtlasExtraction}/LH-CingulatePosterior-mask-orig.nii.gz \
-odt char 

#right precuneus
fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
-thr 62 -uthr 62 -bin \
${outdirAtlasExtraction}/RH-Precu-mask-bin.nii.gz \
-odt char 

fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
-thr 62 -uthr 62 \
${outdirAtlasExtraction}/RH-Precu-mask-orig.nii.gz \
-odt char 

#right cingulate gyrus
fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
-thr 60 -uthr 60 -bin \
${outdirAtlasExtraction}/RH-CingulatePosterior-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedPosteriorAttentionROI.nii.gz \
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

#create binarized mask for each hemisphere
fslmaths ${outdirAtlasExtraction}/LH-Precu-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-CingulatePosterior-mask-bin.nii.gz \
${outdirFinalROI}/LH-posteriorExecutiveAttention-mask-bin.nii.gz

fslmaths ${outdirAtlasExtraction}/RH-Precu-maksk-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-CingulatePosterior-mask-bin.nii.gz \
${outdirFinalROI}/RH-posteriorExecutiveAttention-mask-bin.nii.gz


################ Posterior Language: Posterior Perisylvian Regions ################

#Regions from LATERALIZED HO Cortical Atlas
#41 L Angular Gyrus
#42 R Angular Gyrus
#39 L Supramarginal Gyrus, posterior division
#40 R Supramarginal Gyrus, posterior division
#19 L Superior Temporal Gyrus, posterior division
#20 R Superior Temporal Gyrus, posterior division
#23 L Middle Temporal Gyrus, posterior division
#24 R Middle Temporal Gyrus, posterior division

###Regions omitted
#25 L Middle Temporal Gyrus, temporooccipital part
#26 R Middle Temporal Gyrus, temporooccipital part 

#	#left middle temporal gyrus, temporoocciptal part
#	fslmaths \
#	$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
#	-thr 25 -uthr 25 -bin \
#	${outdirAtlasExtraction}/LH-MTG-mask-bin.nii.gz \
#	-odt char
#	
#	fslmaths \
#	$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
#	-thr 25 -uthr 25 \
#	${outdirAtlasExtraction}/LH-MTG-mask-orig.nii.gz \
#	-odt char
#	
#	#right middle temporal gyrus, temporoocciptal part
#	fslmaths \
#	$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
#	-thr 26 -uthr 26 -bin \
#	${outdirAtlasExtraction}/RH-MTG-mask-bin.nii.gz \
#	-odt char
#	
#	fslmaths \
#	$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
#	-thr 26 -uthr 26 \
#	${outdirAtlasExtraction}/RH-MTG-mask-orig.nii.gz \
#	-odt char


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
-add ${outdirAtlasExtraction}/LH-MTGpost-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-MTGpost-mask-orig.nii.gz \
 ${outdirTempROI}/posteriorLanguageROIs.nii.gz

#create binarized mask to extract residuals for each hemisphere
fslmaths ${outdirAtlasExtraction}/LH-Ang-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-Supram-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-STG-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-MTGpost-mask-bin.nii.gz \
${FinalROI}/LH-posteriorLanguage-mask-bin.nii.gz

fslmaths ${outdirAtlasExtraction}/LH-Ang-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-Supram-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-STG-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-MTGpost-mask-bin.nii.gz \
${FinalROI}/RH-posteriorLanguage-mask-bin.nii.gz


###################### Anterior Language: Inferior Frontal Gyrus ##################

#Regions from LATERALIZED HO Cortical Atlas
#81 L Frontal Operculum 
#82 R Frontal Operculum 
#09 L Inferior Frontal Gyrus, pars triangularis 
#10 R Inferior Frontal Gyrus, pars triangularis 
#11 L Inferior Frontal Gyrus, pars opercularis 
#12 R Inferior Frontal Gyrus, pars opercularis
#65 L Frontal Orbital Gyrus, sliced
#66 R Frontal Orbital Gyrus, sliced

#left frontal operculum
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 81 -uthr 81 -bin \
${outdirAtlasExtraction}/LH-frontOperc-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 81 -uthr 81 \
${outdirAtlasExtraction}/LH-frontOperc-mask-orig.nii.gz \
-odt char

#right frontal operculum
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 82 -uthr 82 -bin \
${outdirAtlasExtraction}/RH-frontOperc-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 82 -uthr 82 \
${outdirAtlasExtraction}/RH-frontOperc-mask-orig.nii.gz \
-odt char

#left inferior frontal gyrus, pars triangularis
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 09 -uthr 09 -bin \
${outdirAtlasExtraction}/LH-parsTri-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 09 -uthr 09 \
${outdirAtlasExtraction}/LH-parsTri-mask-orig.nii.gz \
-odt char

#right inferior frontal gyrus, pars triangularis 
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 10 -uthr 10 -bin \
${outdirAtlasExtraction}/RH-parsTri-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 10 -uthr 10 \
${outdirAtlasExtraction}/RH-parsTri-mask-orig.nii.gz \
-odt char

#left inferior frontal gyrus, pars opercularis
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 11 -uthr 11 -bin \
${outdirAtlasExtraction}/LH-parsOperc-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 11 -uthr 11 \
${outdirAtlasExtraction}/LH-parsOperc-mask-orig.nii.gz \
-odt char

#right inferior frontal gyrus, pars opercularis
fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 12 -uthr 12 -bin \
${outdirAtlasExtraction}/RH-parsOperc-mask-bin.nii.gz \
-odt char

fslmaths \
$FSLDIR/data/atlases/HarvardOxford/HarvardOxford-cortl-maxprob-thr25-1mm.nii.gz \
-thr 12 -uthr 12 \
${outdirAtlasExtraction}/RH-parsOperc-mask-orig.nii.gz \
-odt char

#left frontal orbital gyrus
fslmaths \
${inputDir}/cortl_slicedOrbitalFrontal.nii.gz \
-thr 65 -uthr 65 -bin \
${outdirAtlasExtraction}/LH-frontOrbital-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedOrbitalFrontal.nii.gz \
-thr 65 -uthr 65 \
${outdirAtlasExtraction}/LH-frontOrbital-mask-orig.nii.gz \
-odt char

#right frontal orbital gyrus
fslmaths \
${inputDir}/cortl_slicedOrbitalFrontal.nii.gz \
-thr 66 -uthr 66 -bin \
${outdirAtlasExtraction}/RH-frontOrbital-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedOrbitalFrontal.nii.gz \
-thr 66 -uthr 66 \
${outdirAtlasExtraction}/RH-frontOrbital-mask-orig.nii.gz \
-odt char


#create subset for visualization in fslview and decisions about boundaries
fslmaths ${outdirAtlasExtraction}/LH-frontOperc-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-frontOperc-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-parsTri-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-parsTri-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-parsOperc-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-parsOperc-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-frontOrbital-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-frontOrbital-mask-orig.nii.gz \
 ${outdirTempROI}/anteriorLanguageROIs.nii.gz

#create binarized mask for each hemisphere to extract residuals
fslmaths ${outdirAtlasExtraction}/LH-frontOperc-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-parsTri-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-parsOperc-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-frontOrbital-mask-bin.nii.gz \
${FinalROI}/LH-anteriorLanguage-mask-bin.nii.gz

fslmaths ${outdirAtlasExtraction}/RH-frontOperc-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-parsTri-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-parsOperc-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-frontOrbital-mask-bin.nii.gz \
${FinalROI}/RH-anteriorLanguage-mask-bin.nii.gz

####################### Primary Motor Area ########################################

#Regions manually drawn using MNI 152 template
#1 L Hand Bump
#1 R Hand Bump

#create subset for visualization in fslview 
fslmaths ${inputDir}/STHandbump_LH_20140829.nii.gz \
-add ${inputDir}/STHandbump_RH_20140829.nii.gz \
 ${outdirTempROI}/primaryMotorROIs.nii.gz

#create binarized mask for each hemisphere to extract residuals
cp ${inputDir}/STHandbump_LH_20140829.nii.gz \
${FinalROI}/LH-primaryMotorArea-mask-bin.nii.gz 

cp ${inputDir}/STHandbump_RH_20140829.nii.gz \
${FinalROI}/RH-primaryMotorArea-mask-bin.nii.gz 

####################### Supplementary Motor Area ##################################
#Regions from LATERALIZED HO Cortical Atlas
#47 L Juxtapositional Lobule
#93 R Juxtapositional Lobule

#left juxtapositional lobule
fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 47 -uthr 47 -bin \
${outdirAtlasExtraction}/LH-SMAjuxtaLobule-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 47 -uthr 47 \
${outdirAtlasExtraction}/LH-SMAjuxtaLobule-mask-orig.nii.gz \
-odt char

#right juxtapositional lobule
fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 93 -uthr 93 -bin \
${outdirAtlasExtraction}/RH-SMAjuxtaLobule-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 93 -uthr 93 \
${outdirAtlasExtraction}/RH-SMAjuxtaLobule-mask-orig.nii.gz \
-odt char

#create subset for visualization in fslview and decisions about boundaries
fslmaths ${outdirAtlasExtraction}/LH-SMAjuxtaLobule-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-SMAjuxtaLobule-mask-orig.nii.gz \
 ${outdirTempROI}/supplementaryMotorAreaROIs.nii.gz

#create binarized mask for each hemisphere to extract residuals
cp ${outdirAtlasExtraction}/LH-SMAjuxtaLobule-mask-bin.nii.gz \
${FinalROI}/LH-supplementaryMotorArea-mask-bin.nii.gz

cp ${outdirAtlasExtraction}/RH-SMAjuxtaLobule-mask-bin.nii.gz \
${FinalROI}/RH-supplementaryMotorArea-mask-bin.nii.gz

###################### Anterior EXEC Control: preSMA #############################

#51 L Juxtapositional Lobule
#52 R Juxtapositional Lobule
#05 L Superior Frontal Gyrus
#06 R Superior Frontal Gyrus

#left juxtapositional lobule
fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 51 -uthr 51 -bin \
${outdirAtlasExtraction}/LH-preSMAjuxtaLobule-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 51 -uthr 51 \
${outdirAtlasExtraction}/LH-preSMAjuxtaLobule-mask-orig.nii.gz \
-odt char

#right juxtapositional lobule
fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 52 -uthr 52 -bin \
${outdirAtlasExtraction}/RH-preSMAjuxtaLobule-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 52 -uthr 52 \
${outdirAtlasExtraction}/RH-preSMAjuxtaLobule-mask-orig.nii.gz \
-odt char

#left superior frontal gyrus 
fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 5 -uthr 5 -bin \
${outdirAtlasExtraction}/LH-superiorFrontal-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 5 -uthr 5 \
${outdirAtlasExtraction}/LH-superiorFrontal-mask-orig.nii.gz \
-odt char

#right superior frontal gyrus 
fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 6 -uthr 6 -bin \
${outdirAtlasExtraction}/RH-superiorFrontal-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedJuxtaLobule.nii.gz \
-thr 6 -uthr 6 \
${outdirAtlasExtraction}/RH-superiorFrontal-mask-orig.nii.gz \
-odt char

#create subset for visualization in fslview and decisions about boundaries
fslmaths ${outdirAtlasExtraction}/LH-preSMAjuxtaLobule-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-preSMAjuxtaLobule-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-superiorFrontal-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-superiorFrontal-mask-orig.nii.gz \
 ${outdirTempROI}/preSupplementaryMotorAreaROIs.nii.gz

#create binarized mask for each hemisphere to extract residuals
fslmaths ${outdirAtlasExtraction}/LH-preSMAjuxtaLobule-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-superiorFrontal-mask-bin.nii.gz \
${FinalROI}/LH-anteriorExecutiveAttention-mask-bin.nii.gz

fslmaths ${outdirAtlasExtraction}/RH-preSMAjuxtaLobule-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-superiorFrontal-mask-bin.nii.gz \
${FinalROI}/RH-anteriorExecutiveAttention-mask-bin.nii.gz

###################### Posterior MOTOR Attention: PosteriorCingulate/PreCun ##########
#Regions from LATERALIZED (cortl) H0 Cortical Atlas 
#61 L Precuneus cortex
#59 L Cingulate gyrus, posterior division
#62 R Precuneus cortex
#60 R Cingulate gyrus, posterior division

#creating one file per exisiting region

#left precuneus
fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 61 -uthr 61 -bin \
${outdirAtlasExtraction}/LH-Precu-MOTOR-mask-bin.nii.gz \
-odt char 

fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 61 -uthr 61 \
${outdirAtlasExtraction}/LH-Precu-MOTOR-mask-orig.nii.gz \
-odt char 

#left cingulate gyrus
fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 59 -uthr 59 -bin \
${outdirAtlasExtraction}/LH-CingulatePosterior-MOTOR-mask-bin.nii.gz \
-odt char 

fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 59 -uthr 59 \
${outdirAtlasExtraction}/LH-CingulatePosterior-MOTOR-mask-orig.nii.gz \
-odt char 

#right precuneus
fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 62 -uthr 62 -bin \
${outdirAtlasExtraction}/RH-Precu-MOTOR-mask-bin.nii.gz \
-odt char 

fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 62 -uthr 62 \
${outdirAtlasExtraction}/RH-Precu-MOTOR-mask-orig.nii.gz \
-odt char 

#right cingulate gyrus
fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 60 -uthr 60 -bin \
${outdirAtlasExtraction}/RH-CingulatePosterior-MOTOR-mask-bin.nii.gz \
-odt char

fslmaths \
${inputDir}/cortl_slicedPosteriorMotorAttentionROI.nii.gz \
-thr 60 -uthr 60 \
${outdirAtlasExtraction}/RH-CingulatePosterior-MOTOR-mask-orig.nii.gz \
-odt char

#create subset for visualization in fslview and decisions about boundaries
fslmaths ${outdirAtlasExtraction}/LH-Precu-MOTOR-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/LH-CingulatePosterior-MOTOR-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-Precu-MOTOR-mask-orig.nii.gz \
-add ${outdirAtlasExtraction}/RH-CingulatePosterior-MOTOR-mask-orig.nii.gz \
 ${outdirTempROI}/posteriorMotorAttentionROIs.nii.gz

#create binarized mask for each hemisphere to extract residuals
fslmaths ${outdirAtlasExtraction}/LH-Precu-MOTOR-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/LH-CingulatePosterior-MOTOR-mask-bin.nii.gz \
${FinalROI}/LH-posteriorMotorAttention-mask-bin.nii.gz

fslmaths ${outdirAtlasExtraction}/RH-Precu-MOTOR-mask-bin.nii.gz \
-add ${outdirAtlasExtraction}/RH-CingulatePosterior-MOTOR-mask-bin.nii.gz \
${FinalROI}/RH-posteriorMotorAttention-mask-bin.nii.gz


