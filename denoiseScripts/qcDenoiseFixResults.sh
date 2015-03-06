#!/bin/bash

# created 03/05/2015
# This script is to inspect denoise results applied by FIX. 

# This text file DOES NOT INCLUDE language MA025, motor MA038, and rest MA049 due to exceptionally poor registration, which will be resolved an copied later. 
# Text file that contains a list of all participants and the functional-to-standard registration parameters that were deemed acceptable.
varyingRegistrationInputs="/data/birc/Atlanta/tranThesis/gitRepos/thesis/denoiseScripts/varyingRegistrationInputs.csv"

parentDir="/data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX"

sed 1d $varyingRegistrationInputs | while IFS="," read blind task dof; do

		case $task in 
		
			language)
				session="sessA"
			;;
			motor)
				session="sessB"
			;;
			rest)
				session="sessA"
			;;
		esac


	echo ""
	echo "Begin inspection of denoise results for MA0${blind}, ${task} "
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read
	
	# Visually inspect and compare pre-FIXed and post-FIXed EPIs
	echo "Opening (1) cleaned and (2) uncleaned nifti file"
	fslview ${parentDir}/${task}/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz &
	fslview ${parentDir}/${task}/MA0${blind}_preprocessMELODIC.ica/filtered_fucc_data.nii.gz &

	echo ""
	echo "Move on to the next inspection."
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read

	# Make sure that no noise-labeled components are obvious signal (type 2 error)
	cat ${parentDir}/${task}/MA0${blind}_preprocessMELODIC.ica/fix4melview_standard_thr20.txt

	firefox ${parentDir}/${task}/MA0${blind}_preprocessMELODIC.ica/report.html &	
	
	echo ""
	echo "Move on to the next inspection."
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read

	# Make a temporary directory for the FBIRN QC report	
	tempDir=/tmp/tranDenoiseFIX-${task}-MA0${blind}
	rm -fr ${tempDir}
	mkdir ${tempDir}


	
	echo "Creating .bxh metafile for MA0${blind}..."
	echo ""
	analyze2bxh ${parentDir}/${task}/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz ${tempDir}/epi01.bxh
	echo ""
	echo "...done."
	echo ""
	
	
	echo "Creating FBIRN qc-report."
	echo ""
	qcReportOutDir=${tempDir}/qcReport-FBIRN
	# ...don't mkdir: the fmriqa_generate.pl command will create it.
	fmriqa_generate.pl ${tempDir}/epi01.bxh ${qcReportOutDir}
	echo ""
	echo "...done."
	echo ""

	echo "Inspect qc-report for denoised data."
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read

	echo "Opening (1) denoised QC-report and (2) original QC-report."
	firefox ${qcReportOutDir}/index.html &
	firefox /data/birc/Atlanta/tranThesis/03.derivedData/qualityControl/MA0${blind}/${session}/${task}/qcReport-FBIRN/index.html &

done # done with while-read loop.
