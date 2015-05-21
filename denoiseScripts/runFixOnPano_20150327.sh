#!/bin/bash

# created 2/22/2015 and modified on 3/27/2015 to rerun FIX on a subset of sesssions in which outliers increased. Stephen was unable to replicate this on his mac, so running this now on Pano (was originally ran on Qball3) to see if the problem is platform specific. 
# Input/output is located in /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/fixedThr20_onPano/
# Input is a copy of melodicOutputUnfixed6mm/
# Script to take files preprocessed via MELODIC and apply FSL's training file with pre-labeled noise components. 


# Run fix command separately for task sessions because there are variable sessions missing from each.



# for LANGUAGE sessions. 
		
for blind in 10 12 14 20 21 22 23 27 28 29 31 33 35; do
		/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/fixedThr20_onPano/language/MA0${blind}_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m

done # done with task for-loop


# for MOTOR sessions 
for blind in 27 28 29 31 53 56 58 62 65 66 67 70 74 76 79; do
		
		/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/fixedThr20_onPano/motor/MA0${blind}_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m

done # done with task for-loop


# for REST sessions 
for blind in 10 12 14 20 21 22 23 25 27 28 29 31 33; do

		/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/fixedThr20_onPano/rest/MA0${blind}_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m

done # done with task for-loop
