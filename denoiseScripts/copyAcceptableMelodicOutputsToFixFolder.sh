#!/bin/bash

# Created 03/02/2015
# This script was created to copy all melodic.ica folders with acceptable linear functional-to-standard registration into a single parent folder in the denoiseFIX parent folder. Acceptable registrations varied by the DOF parameter in the Melodic GUI: BBR, 6DOF, or 7DOF.

# Text file DOES NOT INCLUDE language MA025, motor MA038, and rest MA049 due to exceptionally poor registration, which will be resolved an copied later. 
# Text file that contains a list of all participants and the functional-to-standard registration parameters that were deemed acceptable.
varyingRegistrationInputs="/data/birc/Atlanta/tranThesis/gitRepos/thesis/denoiseScripts/varyingRegistrationInputs.csv"

parentDir="/data/birc/Atlanta/tranThesis/03.derivedData"

sed 1d $varyingRegistrationInputs | while IFS="," read blind task dof; do

	case "$dof" in
		
		BBR)
			parentFolder="${task}"
		;;
		6)
			parentFolder="${task}_6DOF"
		;;
		7)
			parentFolder="${task}_7DOF"
		;;
	esac

# copy command options: 
# -a preserves specified attributes such as timestamps and ownership
# -r copies directories recursively (the folder as well as the contents)
cp -ar ${parentDir}/preprocessMELODIC/${parentFolder}/MA${blind}_preprocessMELODIC.ica/ ${parentDir}/denoiseFIX/${task}/

done # done with while-read loop
