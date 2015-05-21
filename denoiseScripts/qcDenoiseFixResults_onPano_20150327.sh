#!/bin/bash

# created 03/06/2015 and modified on 03/27/2015 to inspect FIX results that were recreated on PANO. 
# This script is to inspect denoise results applied by FIX. Consists of a for-loop for each session type (language, motor, rest). 
# Used for-loops because the while-read-loop would not accept user input for some reason. 

parentDir="/data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/fixedThr20_onPano"

# Language
#for blind in 12 31 35; do
#
#	echo ""
#	echo ""
#	echo "Begin inspection of denoise results for MA0${blind}, language"
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#	
#	# Visually inspect and compare pre-FIXed and post-FIXed EPIs
#	echo ""
#	echo "Opening (1) FIX-denoised and (2) original Melodic output nifti file"
#	fslview ${parentDir}/language/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz &
#	fslview ${parentDir}/language/MA0${blind}_preprocessMELODIC.ica/filtered_func_data.nii.gz &
#
#	echo ""
#	echo "Move on to the next inspection."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#	# Make sure that no noise-labeled components are obvious signal (type 2 error)
#	cat ${parentDir}/language/MA0${blind}_preprocessMELODIC.ica/fix4melview_Standard_thr20.txt
#
#	firefox ${parentDir}/language/MA0${blind}_preprocessMELODIC.ica/report.html &	
#	
#	echo ""
#	echo "Move on to the next inspection."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#	# Make a temporary directory for the FBIRN QC report	
#	tempDir=/tmp/tranDenoiseFIXonPano-language-MA0${blind}
#	rm -fr ${tempDir}
#	mkdir ${tempDir}
#
#
#	
#	echo "Creating .bxh metafile for MA0${blind}..."
#	echo ""
#	analyze2bxh ${parentDir}/language/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz ${tempDir}/epi01.bxh
#	echo ""
#	echo "...done."
#	echo ""
#	
#	
#	echo "Creating FBIRN qc-report."
#	echo ""
#	qcReportOutDir=${tempDir}/qcReport-FBIRN
#	# ...don't mkdir: the fmriqa_generate.pl command will create it.
#	fmriqa_generate.pl ${tempDir}/epi01.bxh ${qcReportOutDir}
#	echo ""
#	echo "...done."
#	echo ""
#
#	echo "Inspect qc-report for denoised data."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#	echo "Opening (1) FIX-denoised QC-report and (2) original QC-report."
#	firefox ${qcReportOutDir}/index.html /data/birc/Atlanta/tranThesis/03.derivedData/qualityControl/MA0${blind}/sessA/language/qcReport-FBIRN/index.html /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/fixedThr20/qualityControlThr20/tranDenoiseFIX-language-MA0${blind}/qcReport-FBIRN/index.html &
#
#
#	echo "Completed."
#	echo ""
#	echo "######################################################"
#	echo ""
#	echo "Continue with the next session."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#done # done with for-loop.
#






# Start inspection for motor sessions.MA038 has been ommitted here due to poor registration. 
# MA035, MA049, and MA055 are ommitted because they do not have motor scans.
#for blind in 27 28 29 31 53 56 58 62 65 66 67 70 74 76 79; do
#
#	echo ""
#	echo ""
#	echo "Begin inspection of denoise results for MA0${blind}, motor"
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#	
#	# Visually inspect and compare pre-FIXed and post-FIXed EPIs
#	echo ""
#	echo "Opening (1) FIX-denoised and (2) original Melodic output nifti file"
#	fslview ${parentDir}/motor/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz &
#	fslview ${parentDir}/motor/MA0${blind}_preprocessMELODIC.ica/filtered_func_data.nii.gz &
#
#	echo ""
#	echo "Move on to the next inspection."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#	# Make sure that no noise-labeled components are obvious signal (type 2 error)
#	cat ${parentDir}/motor/MA0${blind}_preprocessMELODIC.ica/fix4melview_Standard_thr20.txt
#
#	firefox ${parentDir}/motor/MA0${blind}_preprocessMELODIC.ica/report.html &	
#	
#	echo ""
#	echo "Move on to the next inspection."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#	# Make a temporary directory for the FBIRN QC report	
#	tempDir=/tmp/tranDenoiseFIXonPano-motor-MA0${blind}
#	rm -fr ${tempDir}
#	mkdir ${tempDir}
#
#
#	
#	echo "Creating .bxh metafile for MA0${blind}..."
#	echo ""
#	analyze2bxh ${parentDir}/motor/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz ${tempDir}/epi01.bxh
#	echo ""
#	echo "...done."
#	echo ""
#	
#	
#	echo "Creating FBIRN qc-report."
#	echo ""
#	qcReportOutDir=${tempDir}/qcReport-FBIRN
#	# ...don't mkdir: the fmriqa_generate.pl command will create it.
#	fmriqa_generate.pl ${tempDir}/epi01.bxh ${qcReportOutDir}
#	echo ""
#	echo "...done."
#	echo ""
#
#	echo "Inspect qc-report for denoised data."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#	echo "Opening (1) FIX-denoised QC-report and (2) original QC-report."
#	firefox ${qcReportOutDir}/index.html /data/birc/Atlanta/tranThesis/03.derivedData/qualityControl/MA0${blind}/sessB/motor/qcReport-FBIRN/index.html /data/birc/atlanta/03.derivedData/denoiseFIX/fixedThr20/qualityControlThr20/tranDenoiseFIX-motor-MA0${blind}/qcReport-FBIRN/index.html &
#
#	echo "Completed."
#	echo ""
#	echo "######################################################"
#	echo ""
#	echo "Continue with the next session."
#	echo ""
#	echo -n "Enter to continue. (or CTRL-C to quit)"
#	read
#
#done # done with for-loop for motor sessions.
#





## Start inspection for rest sessions.MA049 has been ommitted here.
for blind in 28; do

	echo ""
	echo ""
	echo "Begin inspection of denoise results for MA0${blind}, rest"
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read
	
	# Visually inspect and compare pre-FIXed and post-FIXed EPIs
	echo ""
	echo "Opening (1) FIX-denoised and (2) original Melodic output nifti file"
	fslview ${parentDir}/rest/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz &
	fslview ${parentDir}/rest/MA0${blind}_preprocessMELODIC.ica/filtered_func_data.nii.gz &

	echo ""
	echo "Move on to the next inspection."
	echo ""
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read

	# Make sure that no noise-labeled components are obvious signal (type 2 error)
	cat ${parentDir}/rest/MA0${blind}_preprocessMELODIC.ica/fix4melview_Standard_thr20.txt

	firefox ${parentDir}/rest/MA0${blind}_preprocessMELODIC.ica/report.html &	
	
	echo ""
	echo "Move on to the next inspection."
	echo ""
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read

	# Make a temporary directory for the FBIRN QC report	
	tempDir=/tmp/tranDenoiseFIXonPano-rest-MA0${blind}
	rm -fr ${tempDir}
	mkdir ${tempDir}


	
	echo "Creating .bxh metafile for MA0${blind}..."
	echo ""
	analyze2bxh ${parentDir}/rest/MA0${blind}_preprocessMELODIC.ica/filtered_func_data_clean.nii.gz ${tempDir}/epi01.bxh
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
	echo ""
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read

	echo "Opening (1) FIX-denoised QC-report and (2) original QC-report."
	firefox ${qcReportOutDir}/index.html /data/birc/Atlanta/tranThesis/03.derivedData/qualityControl/MA0${blind}/sessA/rest/qcReport-FBIRN/index.html /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/fixedThr20/qualityControlThr20/tranDenoiseFIX-rest-MA0${blind}/qcReport-FBIRN/index.html &


	echo "Completed."
	echo ""
	echo "######################################################"
	echo ""
	echo "Continue with the next session."
	echo ""
	echo -n "Enter to continue. (or CTRL-C to quit)"
	read

done # done with for-loop.
