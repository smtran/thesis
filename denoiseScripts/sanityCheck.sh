#!/bin/bash
# created 2/24/2015
# Script to verify that the correct inputs (i.e., the output filename, EPI, and T1, are all the same subject number, the same session type is used for each participant, and the correct slice timing input) were selected in MELODIC GUI.

# Expected Errors: 
# Language participants 10, 28, and 52 will show "inconsistent session" because of erroneous naming of the output directory. But once created, they were remaned appriately. 
# Motor participant 29 was also mislabeled in the output directory naming and was renamed appropriately later. 

varyingMelodicInputs=$"/data/birc/Atlanta/tranThesis/gitRepos/thesis/denoiseScripts/varyingMelodicInputs.csv"

sed 1d $varyingMelodicInputs | while IFS="," read blind task sliceOrder; do

	case "$task" in
		language)
			sessionType=language
		;;
		motor)
			sessionType=motor
		;;
		rest)
			sessionType=rest
		;;
	esac

	case "$sliceOrder" in
	# Melodic, in design.fsf file, designates 3,5,and 1 for use of slice order file, interleaved, and even-odd sequential ascending, respectively.
		interleaved)
			setFmri=3
		;;
		default)
			setFmri=5
		;;
		ascending)
			setFmri=1
		;;
	esac

currentFile="/data/birc/Atlanta/tranThesis/03.derivedData/preprocessMELODIC/${sessionType}/MA${blind}_preprocessMELODIC.ica/design.fsf"

echo " "
echo "###########################"
echo "blind=${blind}"
echo "sessionType=${sessionType}"
echo "${sliceOrder}=${setFmri}"
echo " "

lineCountBlind="`grep "MA${blind}" ${currentFile} | wc -l`"
# alternative command for extracting number of lines from this result would be | wc | awk '{print $1}'

# lineCountBlind=3
# lineCountBlind=2

if [ ${lineCountBlind} -eq 3 ]
# line count should be 3 because there are 3 instances of the participant number in each design.fsf file: output name, input EPI, and input T1. 
	then 
		echo " "
	else
		echo "INCONSISTENT BLIND!"
fi

# Check if consistent session type was used (language, rest, motor) for inputs.

lineCountSessionType="`grep "${sessionType}" ${currentFile} | wc -l`"

#echo "$lineCountSessionType"

if [ ${lineCountSessionType} -eq 2 ]
# line count should be 2 because there are 2 instances of the session type in each design.fsf file: output name and input EPI.
	then
		echo " "
	else
		echo "INCONSISTENT SESSION TYPE!"
fi

# Check if the correct slice timing was used
sliceTiming="`grep "set fmri(st)" ${currentFile} | awk '{print $3}'`"

# echo "$sliceTiming"

if [ ${setFmri} -eq ${sliceTiming} ]
	then
		echo " "
	else
		echo "INCORRECT SLICE TIMING INPUT"
fi
 
# Check if the correct DOF for main structural registration was correct. Should be BBR.

DOF="`grep "set frmi(reghighres_dof)" ${currentFile} | awk '{print $3}'`"

if [ "${DOF}"="BBR" ]
	then
		echo " "
	else
		echo "INCORRECT DEGREES OF FREEDOM"
fi

done # done with while-read loop
