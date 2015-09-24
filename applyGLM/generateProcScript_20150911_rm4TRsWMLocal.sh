#!/bin/sh

# generateMultipleProcScripts.sh 
# Call this script without any arguments to
# generate a batch of afni_proc proc scripts for all of the participant X task
# combinations listed in $apInputs (below). 
#
# Adapted from Stephen's template 10/20/2014 
# Edited 03/11/2015 to use input from FIX denoise output. 

clear

# I'm using $projectDir to hold the location of my git source dir, where this
# script and supporting files live during development:
projDir="/data/backup/Atlanta/tranThesis/gitRepos/thesis"


# $apInputs is a .csv file coding sessionXsequence variations that will affect
# some afni_proc arguments. This script is written expecting that its contents
# will include a header row followed by data rows, like this:
#
#    blind,seq,sliceOrder
#    010,cowat,interleaved
#    010,motor,interleaved
#    014,cowat,interleaved

# the varyingRegistrationInputs is missing sessions: MA025 language and MA038 motor.
apInputs="${projDir}/applyGLM/varyingAfniProcInputs.csv"
echo ""
echo "\$apInputs==$apInputs"
ls -al $apInputs
echo ""


# Create $tempDirBatch , a  temporary parent directory for output of the entire
# batch (i.e., ~300 line proc scripts for the participants and their afni_proc
# results directories)
startDateTime="`date +%Y%m%d%H%M%S`"
tempDirBatch="/data/backup/Atlanta/tranThesis/03.derivedData/applyGLM/batch-${startDateTime}-rm4TRsWMLocal"
rm -fr ${tempDirBatch}
mkdir -p ${tempDirBatch}
cd ${tempDirBatch}
echo ""
echo "Now in \$tempDirBatch:"
pwd
ls -ald .
echo ""


# The parent directory containing the acquired timeseries:
acqParentDir="/data/backup/Atlanta/tranThesis/03.derivedData"
echo ""
echo "\$acqParentDir==$acqParentDir"
ls -ald $acqParentDir
echo ""


# The number of warm-up TRs that were written to disk at the start
# of each run:
disdacqs=0


################################################################################
# We need afni_proc to create ~300-line proc files for each sessionXtask line
# of the $apInputs file.  This while-read loop below parses the lines of the
# $apInputs file to read the appropriate afni_proc arguments for each
# sessionXtask row.  (The "sed 1d" skips the first line of the file, which is
# just a header line.
################################################################################
echo ""
echo "Creating afni_proc's proc scripts for each of these sessionXtask combinations:"
cat $apInputs
echo ""

# begin while-read loop:
sed 1d $apInputs | while IFS="," read blind task dof; do
   echo "====================================================="
   echo "\$blind==${blind}"
   echo "\$task==${task}"
   echo "====================================================="


   ################################################################################
   # The anatomic T1 (not skull-stripped) to be used as an afni_proc input:
   ################################################################################
   anatWithoutSkull="${acqParentDir}/brainExtractT1/acceptableSkullStrippedT1s/betMA${blind}_t1_brain.nii.gz"
   echo ""
   echo "\$anatWithoutSkull==$anatWithoutSkull"
   ls -al $anatWithoutSkull
   echo ""


   ################################################################################
   # name of epi acqfile depends on whether task is "cowat" or "motor":
   ################################################################################
   epi="${acqParentDir}/denoiseFIX/${task}/MA${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz"
   echo ""
   echo "\$epi==$epi"
   ls -al $epi
   echo ""


   ################################################################################
   # stim times vary by task ($task is read in at top of this while-read loop):
   ################################################################################
   case "$task" in
      language)
         stimTimes="${projDir}/stimulusTiming/stimTimes-cowat-letters-rm2TRs.1D ${projDir}/stimulusTiming/stimTimes-cowat-categories-rm2TRs.1D"
         stimLabel="lets cats"
      ;;
      motor)
         stimTimes="${projDir}/stimulusTiming/stimTimes-motor-left.1D ${projDir}/stimulusTiming/stimTimes-motor-right.1D"
         stimLabel="left right"
      ;;
   esac
   
   echo ""
   echo "\$stimLabel==$stimLabel"
   echo "\$stimTimes==$stimTimes"
   ls -al $stimTimes
   echo ""


   ################################################################################
   # Generate block basis function proc scripts 
   ################################################################################

   # assign a descriptive filename to be used for individual afni_proc results:
   outputName=MA${blind}.${task}.onsetsBlock
   echo ""
   echo "\$outputName==$outputName"
   echo ""

      ################################################################################
      # basis functions vary by task ($task is read in at top of this while-read loop):
      ################################################################################
      #
      # per Andy: 
      #   cowat active blocks are 15s, followed by rest of 15s
      #   motor active blocks are 18s, followed by rest of 10s
      #
      # per stowler:
      #   TENT funcions won't execute on these cowat data without using the
      #   GOFORIT arguments to push through AFNI's warnings about matrix
      #   problems (see case statements below for where I'm using variables
      #   $goforit3dD and $goforitREML). 
      #
      # per Stella:
      #   Removed commands to run TENT functions; only doing BLOCK.

      case "$task" in
         language)
            basisFxn="BLOCK5(15,1)"
         ;;
         motor)
            basisFxn="BLOCK5(18,1)"
         ;;
      esac
      echo ""
      echo ""

      #########################################################
      # afni_proc.py command :
      #########################################################
      afni_proc.py \
      -subj_id ${outputName} \
      -script proc.${outputName} \
      -out_dir results.${outputName} \
      -dsets ${epi} \
      -copy_anat ${anatWithoutSkull} \
      -anat_has_skull no \
      -blocks align volreg mask scale regress \
      -tcat_remove_first_trs 2 \
      -tcat_remove_last_trs 2 \
      -volreg_align_to first \
      -volreg_interp -Fourier \
      -regress_anaticor \
      -regress_stim_times ${stimTimes} \
      -regress_stim_labels ${stimLabel} \
      -regress_basis ${basisFxn} \
      -regress_apply_mot_types demean \
      -regress_censor_outliers 0.9 \
      -regress_compute_fitts \
      -regress_opts_3dD -fout -rout -nobout -jobs 8 \
      -regress_opts_reml -quiet \
      -regress_run_clustsim yes \
      -regress_est_blur_epits \
      -regress_est_blur_errts \
      -regress_reml_exec \

done # end of out while-read loop
