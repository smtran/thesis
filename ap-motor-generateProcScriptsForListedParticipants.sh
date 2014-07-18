#!/bin/sh

################################################################################
# This script uses AFNI's afni_proc.py command to launch modern single-session
# preprocessing and analysis. To launch your analysis and review results:
# 
# 1. Execute this afni_proc script with "bash [thisScriptName]" (no quotes or
#    square brackets)
# 2. Execute the resulting proc.* script using the directions printed at the
#    end of step one's output (e.g., "tcsh -xef proc.exampleParticipant |& tee output.proc.exampleParticipant")
# 3. After the script completes, look for errors with "less output.proc.exampleParticipant")
# 4. cd to the results directory and review your results by 
################################################################################



#########################################################
# VARIABLE DEFINITIONS:
#########################################################

# Define variables to be used in this script's call to afni_proc. These values
# could also be given directly to afni_proc, but storing them in variables
# first makes your afni_proc command more readable.
while read line; do


# ...participant identifier to be used in output filenames:
#participant="AF_02"
participant=`echo "${line}" | cut -d ' ' -f 1`
#echo "DEBUG: the values of the variable participant is ${participant}"
#exit

# ...EPI timeseries to be used as afni_proc inputs:
#acqfiles="/data/birc/Atlanta/tranThesis/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/AF_02/sess0/motor/fmriSeriesMot_epi04_MNI.nii.gz /data/birc/Atlanta/tranThesis/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/AF_02/sess0/motor/fmriSeriesMot_epi05_MNI.nii.gz"
run1=`echo "${line}" | cut -d ' ' -f 2`
run2=`echo "${line}" | cut -d ' ' -f 3`
acqfiles="${run1} ${run2}"
# echo "DEBUG: the value of the variable acqfiles should include two space-separated paths to niftis: "
# echo "${acqfiles}"
# exit

# ...anatomic T1 (not skull-stripped) to be used as an afni_proc input:
#anatWithSkull="/data/birc/Atlanta/tranThesis/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/AF_02/sess0/T1/series-t1_MNI.nii.gz"
anatWithSkull=`echo "${line}" | cut -d ' ' -f 4`

# ...number of warm-up TRs that were collected at the start of each run:
#	using 0 per AFNI history from Keith's orignal analysis:
#	3dinfo SUBJECTS/AF_s112/afnifiles/s112.tapping1.reg.Znorm+orig.HEAD
#	...(snip)...
#	[kmcgrego@genu.phhp.ufl.edu: Sat Aug  8 08:39:32 2009] [kmcgrego@genu.phhp.ufl.edu: Sat Aug  8 08:39:08 2009] 3dTcat -rlt++ -prefix s112.tapping1.reg 's112.tapping1.treg+orig[0..69]'
#	...(snip)...
disdacqs=0

# ...stimulus timing files detailing task timing were provided from Keith's original analysis. We confirmed that there are no timing differences among sessions/participants:
#	cd /data/birc/Florida/AEROBIC_FITNESS
# 	for file in SUBJECTS/AF_s*/afnifiles/timeFILETAPPINGMINUS4.1D; do 1dtranspose $file; done | sort | uniq
#	...the results of which also match the only stim time file that isn't in a participant directory:
#	cat SUBJECTS/timeFILETAPPINGMINUS4.1D
stimTimesMotor="/data/birc/Florida/AEROBIC_FITNESS/SUBJECTS/timeFILETAPPINGMINUS4.1D"


# ...blur size:
# (at the moment: using Keith's original value of 5, from
#	stowler@pano:/data/birc/Florida/AEROBIC_FITNESS$ 3dinfo SUBJECTS/AF_s112/afnifiles/s112.tapping.Znorm_amask_5blr+orig.HEAD
#	...(snip)...
#	[kmcgrego@shim.phhp.ufl.edu: Wed Oct  7 16:34:29 2009] 3dmerge -1blur_fwhm 5 -doall -prefix s112.tapping.Znorm_amask_5blr s112.tapping.Znorm_amask+orig
#	...(snip)...
blurMM=5




#########################################################
# afni_proc.py command and explanations:
#########################################################

# Here is the afni_proc.py command executed for this analysis, and below that
# command is an explanation of the command arguments (subcommands):


afni_proc.py \
-subj_id ${participant} \
-script proc.motor.${participant} \
-out_dir results.motor.${participant} \
-dsets ${acqfiles} \
-copy_anat ${anatWithSkull} \
-blocks tshift align volreg blur mask scale regress \
-tcat_remove_first_trs ${disdacqs} \
-tshift_interp -Fourier \
-tshift_opts_ts -verbose -tpattern seq+z \
-volreg_align_to third \
-volreg_interp -Fourier \
-blur_size ${blurMM} \
-regress_stim_times ${stimTimesMotor} \
-regress_stim_labels motor \
-regress_basis 'BLOCK(28,1)' \
-regress_apply_mot_types demean \
-regress_censor_motion 0.3 \
-regress_censor_outliers 0.1 \
-regress_compute_fitts \
-regress_opts_3dD -fout -rout -nobout -jobs 8 \
-regress_run_clustsim yes \
-regress_est_blur_epits \
-regress_est_blur_errts \
-regress_reml_exec

done<apInputsMotor.txt

# gives per-stim-class fstats:
#       -regress_opts_3dD -jobs 8 \

# TBD: I got rid of opt_3dD tout as a test
# ...and -regress_reml_exec

# In order of appearance in this script's call to afni_proc.py, here are
# explanations of the afni_proc.py arguments (subcommands) used:
#


# Tell afni_proc.py how to name output and where to put it. Establishing the
# participant identifier as a variable before the afni_proc command makes this
# easier:
#       -subj_id ${participant} 
#       -script proc.${participant} 
#       -out_dir results.${participant} 


# Tell afni_proc where to find the EPI timeseries that will server as inputs
# for the analysis. Storing this in a variable before the afni_proc command
# makes afni_proc more readable:
#       -dsets ${acqfiles}

# Tell afni_proc to copy the anatomic T1 to the results directory. You'll want
# it in the results directory so you can use it as an underlay:
#       -copy_anat ${anatWithSkull}

# You can controls the inclusion and order of processing steps using the
# "-blocks" argument. Below is a list of the available blocks in their default
# order. Compare to the "-blocks" argument actually used in this script above.
#   despike     truncate spikes in each voxel's time series (via 3dDespike)
#   ricor       remove the cardiac/respiratory signal from EPI (RETROICOR)
#   tshift      per-volume correction of slice timing alignment
#   align       calculate alignment between anat and EPI (via align_epi_anat.py -anat2epi -epi_strip Automask)
#   tlrc        calculate alignment between anat and standard space template
#   volreg      motion correction, plus writes outputs of EPI/anat/standard space alignment
#   blur        spatially smooth each TR (guide: 1.5 * longest voxel side in mm)
#   mask        create a brain mask from the EPI data
#   scale       within EPI run, scale the timeseries of each voxel to mean 100, range [0,200]
#   regress     voxelwise GLM calculation of fit between task timing and collected EPIs

# Tell afni_proc to remove any warm-up TRs that were collected at the begining
# of each run:
#       -tcat_remove_first_trs ${disdacqs} 

# Motion correction: tell afni_proc to spatially align all EPI timepoints to
# the first volume of the first run, and do so using best available
# spatial interpolation:
#       -volreg_align_to first
#       -volreg_interp -Fourier
# Without including -volreg_align_e2a, this also means that the anat is aligned
# to EPI and all processing is done in native space


# Tell afni_proc to spatially smooth each TR by adding a ___ mm FWHM gaussian
# kernel to whatever spatial smoothness already exists. How much to smooth?  A
# good staring place is 1.5 * the longest side of EPI acquisition voxel :
#       - blur_size 4.5


# If there was large movement, censor the TRs on either side of that movement.
# The greatest acceptable motion is specified as the number after this argument,
# in units of Euclidean Norm of the motion parameters (see 1d_tool.py)
#       -regress_censor_motion 0.3 


# Censor any TRs that have too many outlier voxels. The number represents the
# proportion of outlier voxels that will result in censorship of a TR. For
# example, -regress_censor_outliers 0.1 will censor every TR in which the
# number of outlier voxels is > 10%. The judgement of whether a voxel is an
# outlier is performed by AFNI's '3dToutcount -automask -fraction'
#       -regress_censor_outliers 0.1

# Save RAM during 3dDeconvolve:
#       - regress_compute_fitts


# Request that afni_proc create specific output statistics via the
# -regress_opts_3dD subcommand, which passes its options to the AFNI program
# 3dDeconvolve (e.g. -regress_opts_3dD [option1] [option2]). Options:
#
#       -fout
#       "Output the F-stat for each stimulus class. F tests the null hypothesis
#       that each and every beta coefficient in the stimulus se t is zero. If
#       there is only 1 stimulus class, then its '-fout' value is redundant
#       with Full_Fstat"
#
#       -rout
#       flag to output the R^2 statistics
#
#       -tout
#       Flag to output the t-statistic for each beta. "t tests a single beta
#       coefficient against zero...If a stimulus class has only one regressor,
#       then F = T^2 and the F statistic is redundant with it"
#
#       -nocout
#       Flag to suppress output of regression coefficients.
#
#       -nobout
#       Flag to suppress output of baseline coefficients. 


# Perform the calculations to provide family-wise error correction via
# clustering (triggers 3dClustSim). The first is the relevant subcommand, but
# it won't run without the second and third:
#       -regress_run_clustsim yes
#       -regress_est_blur_epits
#       -regress_est_blur_errts
#
# Run the REML version of the analysis:
#       -regress_reml_exec



