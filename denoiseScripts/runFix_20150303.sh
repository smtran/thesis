#!/bin/bash

# created 2/22/2015
# Script to take files preprocessed via MELODIC and apply FSL's training file with pre-labeled noise components. 


# Run fix command separately for task sessions because there are variable sessions missing from each.



# for LANGUAGE sessions. 
# Missing MA025 due to poor registration, will be resolved later.
		
for blind in 10 12 14 20 21 22 23 27 28 29 31 33 35 36 38 39 41 44 46 49 52 53 55 56 58 62 65 66 67 70 74 76 79; do
		/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/language/MA0${blind}_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m

done # done with task for-loop


# for MOTOR sessions 
# Missing MA038 due to poor registration, will be resolved later.
# Missing MA035, MA049, and MA055 because there is no motor data for these participants
for blind in 10 12 14 20 21 22 23 25 27 28 29 31 33 36 39 41 44 46 52 53 56 58 62 65 66 67 70 74 76 79; do
		
		/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/motor/MA0${blind}_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m

done # done with task for-loop


# for REST sessions 
# Missing MA049 due to poor registration, will be resolved later.
for blind in 10 12 14 20 21 22 23 25 27 28 29 31 33 35 36 38 39 41 44 46 52 53 55 56 58 62 65 66 67 70 74 76 79; do

		/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/rest/MA0${blind}_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m

done # done with task for-loop
