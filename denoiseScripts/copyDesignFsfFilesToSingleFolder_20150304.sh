#/bin/bash

# created 03/04/2015
# Melodic preprocessing was originally applied with 5mm smoothing to replicate what the FSL authors used for their pre-labeled noise components. It was decided by mentors that 6mm smoothing would be most appropriate for these data. This script was created to take the existing design.fsf files for each session and copy then into a single folder, then change the smoothing and output in each design.fsf file. 

parentDir="/data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX"

varyingRegistrationInputs="/data/birc/Atlanta/tranThesis/gitRepos/thesis/denoiseScripts/varyingRegistrationInputs.csv"

sed 1d $varyingRegistrationInputs | while IFS="," read blind task dof; do

# copy files to single folder and rename
cp ${parentDir}/melodicOutputFWHM5mm/${task}/MA${blind}_preprocessMELODIC.ica/design.fsf ${parentDir}/designFsfFiles/MA${blind}_${task}_design.fsf


currentFile="${parentDir}/designFsfFiles/MA${blind}_${task}_design.fsf"

# Smoothing is specified on line 109. Substitute 5 for 6 on that line. 
# To make sure this is true:
# sed -n '/set fmri(smooth)/p' $currentFile # This will list all the lines that contrain "set fmri(smooth)"
# cat $currentFile | sed -e "109s/5/6/" > $currentFile # This should do the same thing as below.
ed -s $currentFile <<< $'/set fmri(smooth)/s/5/6/g\nw'

# Output is specified on line 33. 
#cat $currentFile | sed -e "33s/\\/data\\/birc\\/Atlanta.*/\\/data\\/birc\\/Atlanta\\/tranThesis\\/03.derivedData\\/denoiseFIX\\/${task}\\/MA${blind}_preprocessMELODIC.ica/" > $currentFile

# ed -s $currentFile <<< $'/set fmri(outputdir)/s/\\/data\\/birc\\/Atlanta*/s/\\/data\\/birc\\/Atlanta\\/tranThesis\\/03.derivedData\\/denoiseFIX\\/${task}\\/MA${blind}_preprocessMELODIC.ica/g\nw'

#cat $currentFile | sed -e "/set fmri(outputdir)/c|'set fmri(outputdir) /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/${task}/MA${blind}_preprocessMELODIC.ica'" > $currentFile


done # done with while-read loop
