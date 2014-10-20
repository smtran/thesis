#!/bin/sh
# generateMultipleProcScrips.sh
#Call this script without any arguments to generate batch of afni_proc scripts for all the participant X task combinations listedin $apInputs (below)

clear

projDir=~/gitRepos/thesis/afniProcScripts


#$apInputs is a .csv file coding sessionXsequence variation that will affect some afni_proc arguments. This script is written expecting that its contents will include a header row followed by data rows, like this:
#
# blind,seq,sliceOrder
# 010,cowat,interleaved
# 010,motor,interleaved
# 014,cowat,interleaved
#
apInputs=${projDir}/varyingAfniprocInputs.csv
echo ""


#create $tempDirBatch, a temporary directory for output of entire batch (i.e., ~300 line proc scripts for the participants and their afni_proc result directories)
startDateTime="'date+%Y%m%d%H%S'"
rm -fr ${tempDirBatch}
cd ${tempDirBatch}
echo ""
echo "Now in \$tempDirBatch:"
pwd
ls -ald
echo ""


# The parent directory containing the acquired timeseries:
acqParentDir="/data/birc/Atlanta/tranThesis/UAMS_data/UAMS_data_xferred"
echo ""
echo "\$acqParentDir==$acqParentDir"
ls -ald $acqParentDir
echo ""


#The number of warm-up TRs that were written to disk at the start of each run
disdacqs=0

################################################################
# We need afni_proc to creat ~300-line proc files for each sessionXtask line of the $apInputs file. This while-read loop below parses the lines of the $apInputsfile to read the appropriate afni_proc argumets for each sessionXtask row.  (The "sed 1d" skips the first line of the file, which is just a header file.
###############################################################

echo ""
echo "Creating afni_proc's proc scripts for each of these sessionXtask combinations"
cat $apInputs
echo ""

#begin while-read loop:
sed 1d $adInputs | while IFS="," read blind task sliceOrder; do
	echo "================================================"
	echo "\$blind==${blind}"
	echo "\$task==${task}"
	echo "\$sliceOrder==${sliceOrder}"
	echo "==============================================="

	######################################################################
	#The anatomic T1 (not skull stripped) to be used as an afni_proc input:
	######################################################################
	anatWithSkull="/data/birc/Atlanta/tranThesis/UAMS_data/UAMS_anat/COG.C.${blind}.anat.nii"
	echo ""
	echo "\$anatWithSkull==$anatWithSkull"
	ls -al $anatWithSkull
	echo ""

	######################################################################
	#Name of epi acqfile depends on whether task is "cowat" or "motor":
	#####################################################################
	epi="${acqParentDir}/COG.${blind}.${task}.nii"
	echo ""
	echo "\$epi==$epi"
	ls -al $epi
	echo ""

	#####################################################################
	#Stim times vary by task ($task is read in at top of this while-red loop:)
	#####################################################################
	case "$sliceOrder" in
		interleaved)
			sliceTimes="${projDir
