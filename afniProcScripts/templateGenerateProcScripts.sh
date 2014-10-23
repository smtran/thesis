#!/bin/sh

# generateMultipleProcScripts.sh 
# Call this script without any arguments to
# generate a batch of afni_proc proc scripts for all of the participant X task
# combinations listed in $apInputs (below). 
#
# Written as a template for Stella Tran to follow for her thesis.
# -stowler@gmail.com, August 2014

clear

# I'm using $projectDir to hold the location of my git source dir, where this
# script and supporting files live during development:
projDir=${HOME}/gitrepos/proj.stran.thesis


# $apInputs is a .csv file coding sessionXsequence variations that will affect
# some afni_proc arguments. This script is written expecting that its contents
# will include a header row followed by data rows, like this:
#
#    blind,seq,sliceOrder
#    010,cowat,interleaved
#    010,motor,interleaved
#    014,cowat,interleaved
#
apInputs="${projDir}/acquisitionCharacterics/varyingAfniprocInputs.csv"
echo ""
echo "\$apInputs==$apInputs"
ls -al $apInputs
echo ""


# Create $tempDirBatch , a  temporary parent directory for output of the entire
# batch (i.e., ~300 line proc scripts for the participants and their afni_proc
# results directories)
startDateTime="`date +%Y%m%d%H%M%S`"
tempDirBatch="${HOME}/temp/batch-tranThesis-${startDateTime}"
rm -fr ${tempDirBatch}
mkdir -p ${tempDirBatch}
cd ${tempDirBatch}
echo ""
echo "Now in \$tempDirBatch:"
pwd
ls -ald .
echo ""


# The parent directory containing the acquired timeseries:
acqParentDir="/data/birc/Atlanta/tranThesis/acqfiles/transfer"
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
sed 1d $apInputs | while IFS="," read blind task sliceOrder; do
   echo "====================================================="
   echo "\$blind==${blind}"
   echo "\$task==${task}"
   echo "\$sliceOrder==${sliceOrder}"
   echo "====================================================="


   ################################################################################
   # The anatomic T1 (not skull-stripped) to be used as an afni_proc input:
   ################################################################################
   anatWithSkull="${acqParentDir}/COG.C.${blind}.anat.nii"
   echo ""
   echo "\$anatWithSkull==$anatWithSkull"
   ls -al $anatWithSkull
   echo ""


   ################################################################################
   # name of epi acqfile depends on whether task is "cowat" or "motor":
   ################################################################################
   epi="${acqParentDir}/COG.C.${blind}.${task}.nii"
   echo ""
   echo "\$epi==$epi"
   ls -al $epi
   echo ""


   ################################################################################
   # stim times vary by task ($task is read in at top of this while-read loop):
   ################################################################################
   case "$task" in
      cowat)
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
   echo ""


   ################################################################################
   # slice timing varies by slice order ($sliceOrder is read in at top of this while-read loop):
   ################################################################################
   case "$sliceOrder" in
      interleaved)
         sliceTimes="${projDir}/acquisitionCharacterics/fromAndy/interleaved_slice_timing_TR2000ms_37slices.txt.txt"
      ;;
      ascending)
         sliceTimes="${projDir}/acquisitionCharacterics/fromAndy/seq_ascending_slice_timing_TR2000ms_37slices.txt.txt"
      ;;
   esac
   echo ""
   echo "\$sliceTimes==$sliceTimes"
   echo ""


   ################################################################################
   # Generate two separate proc scripts for each trip through the current
   # while-read loop (i.e., for each sessionXtask combination): one with block
   # basis functions and one with tent basis functions. Equivalent in all other
   # ways, this makes it easy to generate simultaneous block and tent results
   # for comparison with eachother during development.
   ################################################################################
   for basisFxnName in Block Tent; do
      
      # assign a descriptive filename to be used for individual afni_proc results:
      outputName=COG.C.${blind}.${task}.onsetsBlock.basis${basisFxnName}
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
      #   This means TENT results may not be valid. Careful evaluation of the
      #   regressors is required to decide whether the results should be
      #   trusted. See the BLOCK and TENT warnings I pasted at the bottom of
      #   this script.

      case "$basisFxnName" in
         Block) # basis functions for fixed-shape (block) HRF analysis:
               case "$task" in
                  cowat)
                     basisFxn="BLOCK(15,1)"
                     goforit3dD=""
                     goforitREML=""
                  ;;
                  motor)
                     basisFxn="BLOCK(18,1)"
                     goforit3dD=""
                     goforitREML=""
                  ;;
               esac
         ;;
         Tent) # basis functions for variable-shape HRF analysis:
               case "$task" in
                  cowat)
                     basisFxn="TENT(0,20,11)"
                     goforit3dD="-GOFORIT 3"
                     goforitREML="-GOFORIT"
                  ;;
                  motor)
                     basisFxn="TENT(0,22,12)"
                     goforit3dD=""
                     goforitREML=""
                  ;;
               esac
         ;;
      esac
      echo ""
      echo "\$basisFxn==$basisFxn"
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
      -blur_size 5.5 \
      -regress_stim_times ${stimTimes} \
      -regress_stim_labels ${stimLabel} \
      -regress_basis ${basisFxn} \
      -regress_apply_mot_types demean \
      -regress_censor_motion 0.3 \
      -regress_censor_outliers 0.1 \
      -regress_compute_fitts \
      -regress_opts_3dD -fout -nobout -jobs 8 ${goforit3dD} \
      -regress_opts_reml -quiet ${goforitREML} \
      -regress_run_clustsim yes \
      -regress_est_blur_epits \
      -regress_est_blur_errts \
      -regress_reml_exec 
   done # end of for loop
done # end of out while-read loop



#  WARNINGS FROM BLOCK BASIS FUNCTION:
#
#  -------------------- regession warnings --------------------
#  --- no 3dDeconvolve.err warnings file ---
#  
#  --- no out.TENT_warn.txt warnings file ---
#  
#  ----------- correlation warnings -----------
#  
#  Warnings regarding Correlation Matrix: X.xmat.1D
#  
#    severity   correlation   cosine  regressor pair
#    --------   -----------   ------  ----------------------------------------
#    medium:      -0.401       0.000  ( 4 vs.  5)  lets#0  vs.  cats#0



#  WARNINGS FROM TENT BASIS FUNCTION:
#
#  -------------------- regession warnings --------------------
#  ------------- 3dDeconvolve.err -------------
#  *+ WARNING: !! in Signal+Baseline matrix:
#   * Largest singular value=2.40065
#   * 2 singular values are less than cutoff=2.40065e-07
#   * Implies strong collinearity in the matrix columns!
#  *+ WARNING: !! in Signal-only matrix:
#   * Largest singular value=1.41421
#   * 2 singular values are less than cutoff=1.41421e-07
#   * Implies strong collinearity in the matrix columns!
#  *+ WARNING: +++++ !! Matrix inverse average error = 0.0214844  ** BEWARE **
#  *+ WARNING: !! 3dDeconvolve -GOFORIT is set to 3: running despite 3 matrix warnings
#  *+ WARNING: !! See file 3dDeconvolve.err for all WARNING and ERROR messages !!
#  *+ WARNING: !! Please be sure you understand what you are doing !!
#  *+ WARNING: !! If in doubt, consult with someone or with the AFNI message board !!
#  --------------------------------------------
#  
#  ------------ out.TENT_warn.txt -------------
#  --------------------------------------------
#  
#  ----------- correlation warnings -----------
#  
#  Warnings regarding Correlation Matrix: X.xmat.1D
#  
#    severity   correlation   cosine  regressor pair
#    --------   -----------   ------  ----------------------------------------
#    medium:       0.697       0.707  (24 vs. 25)  cats#9  vs.  cats#10
#    medium:       0.695       0.707  (15 vs. 16)  cats#0  vs.  cats#1
#    medium:       0.695       0.707  (13 vs. 14)  lets#9  vs.  lets#10
#    medium:       0.695       0.707  ( 4 vs.  5)  lets#0  vs.  lets#1
#    medium:       0.495       0.527  (21 vs. 22)  cats#6  vs.  cats#7
#    medium:       0.472       0.500  (23 vs. 24)  cats#8  vs.  cats#9
#    medium:       0.464       0.500  (20 vs. 21)  cats#5  vs.  cats#6
#    medium:       0.464       0.500  (18 vs. 19)  cats#3  vs.  cats#4
#    medium:       0.464       0.500  (19 vs. 20)  cats#4  vs.  cats#5
#    medium:       0.464       0.500  (17 vs. 18)  cats#2  vs.  cats#3
#    medium:       0.464       0.500  (16 vs. 17)  cats#1  vs.  cats#2
#    medium:       0.464       0.500  (12 vs. 13)  lets#8  vs.  lets#9
#    medium:       0.464       0.500  (11 vs. 12)  lets#7  vs.  lets#8
#    medium:       0.464       0.500  ( 8 vs.  9)  lets#4  vs.  lets#5
#    medium:       0.464       0.500  ( 7 vs.  8)  lets#3  vs.  lets#4
#    medium:       0.464       0.500  (10 vs. 11)  lets#6  vs.  lets#7
#    medium:       0.464       0.500  ( 9 vs. 10)  lets#5  vs.  lets#6
#    medium:       0.464       0.500  ( 6 vs.  7)  lets#2  vs.  lets#3
#    medium:       0.464       0.500  ( 5 vs.  6)  lets#1  vs.  lets#2
#    medium:       0.440       0.471  (22 vs. 23)  cats#7  vs.  cats#8
#  
#  --------------------------------------------

