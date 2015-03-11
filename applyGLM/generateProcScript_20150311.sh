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
projDir="/data/birc/Atlanta/tranThesis/gitRepos/thesis/"


# $apInputs is a .csv file coding sessionXsequence variations that will affect
# some afni_proc arguments. This script is written expecting that its contents
# will include a header row followed by data rows, like this:
#
#    blind,seq,sliceOrder
#    010,cowat,interleaved
#    010,motor,interleaved
#    014,cowat,interleaved
#
apInputs="${projDir}/acquisitionCharacteristics/varyingAfniprocInputs.csv"
echo ""
echo "\$apInputs==$apInputs"
ls -al $apInputs
echo ""


# Create $tempDirBatch , a  temporary parent directory for output of the entire
# batch (i.e., ~300 line proc scripts for the participants and their afni_proc
# results directories)
startDateTime="`date +%Y%m%d%H%M%S`"
tempDirBatch="/data/birc/Atlanta/tranThesis/03.derivedData/afniProcScriptOutput/batch-tranThesis-giantMove-${startDateTime}"
rm -fr ${tempDirBatch}
mkdir -p ${tempDirBatch}
cd ${tempDirBatch}
echo ""
echo "Now in \$tempDirBatch:"
pwd
ls -ald .
echo ""


# The parent directory containing the acquired timeseries:
acqParentDir="/data/birc/Atlanta/tranThesis/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/"
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
sed 1d $apInputs | while IFS="," read blind task session sliceOrder; do
   echo "====================================================="
   echo "\$blind==${blind}"
   echo "\$task==${task}"
   echo "\$session==${session}"
   echo "\$sliceOrder==${sliceOrder}"
   echo "====================================================="


   ################################################################################
   # The anatomic T1 (not skull-stripped) to be used as an afni_proc input:
   ################################################################################
   anatWithSkull="${acqParentDir}/MA${blind}/sessA/T1/MA${blind}_MNI.nii.gz"
   echo ""
   echo "\$anatWithSkull==$anatWithSkull"
   ls -al $anatWithSkull
   echo ""


   ################################################################################
   # name of epi acqfile depends on whether task is "cowat" or "motor":
   ################################################################################
   epi="${acqParentDir}/MA${blind}/sess${session}/${task}/epi01_MNI.nii.gz"
   echo ""
   echo "\$epi==$epi"
   ls -al $epi
   echo ""


   ################################################################################
   # stim times vary by task ($task is read in at top of this while-read loop):
   ################################################################################
   case "$task" in
      language)
         stimTimes="${projDir}/stimulusTiming/stimTimes-cowat-letters.1D ${projDir}/stimulusTiming/stimTimes-cowat-categories.1D"
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
   # slice timing varies by slice order ($sliceOrder is read in at top of this while-read loop):
   ################################################################################
   case "$sliceOrder" in
      interleaved)
         sliceTimes="${projDir}/acquisitionCharacteristics/interleaved_slice_timing_TR2000ms_37slices.txt"
      ;;
      ascending)
         sliceTimes="${projDir}/acquisitionCharacteristics/seq_ascending_slice_timing_TR2000ms_37slices.txt"
      ;;
      default)
	 sliceTimes="${projDir}/acquisitionCharacteristics/default_slice_timing_TR2000_sl37.txt"
      ;;
   esac
   echo ""
   echo "\$sliceTimes==$sliceTimes"
   ls -al $sliceTimes
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
      -copy_anat ${anatWithSkull} \
      -blocks tshift align volreg blur mask scale regress \
      -tshift_interp -Fourier \
      -tshift_opts_ts -tpattern @${sliceTimes} \
      -tcat_remove_first_trs ${disdacqs} \
      -volreg_align_to first \
      -volreg_interp -Fourier \
      -blur_size 6 \
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
      -align_opts_aea -giant_move
done # end of out while-read loop







