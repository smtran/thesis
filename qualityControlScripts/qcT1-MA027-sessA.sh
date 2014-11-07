#!/bin/bash
#
# created: 20140612 by stowler@gmail.com
# edited:  20140612 by stowler@gmail.com
#
# This is a short script to illustrate conversion of tranThesis acquisition T1
# to FSL152 MNI-oriented (not spatially coregistered: just reoriented)

#
# - It is currently designed for T1 from a single session of scanning
#   (i.e., one trip to the scanner, or one "study"). 
# - It is not written to accept commandline arguments. Instead, make a copy of
#   the script and edit the information specific to your particpant, session, and
#   sequences.
 
clear
 
#############################################################################
# STEP 0: Assign values to variables that will be used in output file names:
# e.g., 
#   participant=CDA100
#   session=pre
#   sequences=fmriCategoryMemberGen
#
projectName=tranThesis
participantNumber=027
participant=MA${participantNumber} 
session=sessA
sequences=T1
 
 
#############################################################################
# STEP 1: Create the variable ${tempDir} , and assign to it the full path of a
# temporary output directory in which we'll inspect output
#
# Details: We'll start by deleting any existing version of this directory, and
# the recreating it. That avoids accidentally mixing old aborted data with the
# data we're creating here.
#
# e.g., tempDir=/tmp/qc-nocera-CDA100-pre-namingruns
#
tempDir=/tmp/qcTran-${participant}-${session}-${sequences}
rm -fr ${tempDir}
mkdir ${tempDir}
 
 
#############################################################################
# STEP 2: Create the variable ${sourceParentDir}
#
# Details: Create the variable ${sourceParentDir} and assign to it the full
# path of the parent folder that contains source folders for each of the
# scanner-exported nifti series in this session:
#
# sourceParentDir=/data/birc/Florida/AEROBIC_FITNESS/SUBJECTS/AF_s02/AF_s02/acqfiles
#
sourceParentDir=/data/birc/Atlanta/tranThesis/UAMS_data/UAMS_anat
 
 
#############################################################################
# STEP 3: Create the variable ${seriesList}, and assign its value: a
# space-separated list of the series you are about to work with. 
#
# Details: Per the way the original data were stored, the individual
# series are stored in folders named according to order of series acquision.
# Create the list to reflect the temporal order of acquisition. This allows the
# resulting data to be interpreted with the knowledge that the first series 
# in the results was acquried before the second series, etc.
#
# e.g., seriesList="4 5 6 7 8 9"
#
# For T1 series, it's perfectly acceptable to have just one T1, i.e., 
# seriesList="t1"
#

#seriesList="t1"
 
 
#############################################################################
# STEP 4: For each series, do three things:
#
#   1) create the .bxh metadata file (command: analyze2bxh)
#   2) generate a new nifti file from the metadata and the original (command: bxh2analyze --nii)
#   3) reorient that nifti file into gross alignment with the MNI 152 template (command: fslreorient2std)
#
# NB: Even if our exported data from the scanner is in NIFTI format, it's worth
# going through this conversion pipeline to get to MNI152 orientation in a way
# that is consistent across series regarless of whether they were exported as
# DICOM, NIFTI, PAR/REC, etc.
 
echo ""
echo ""
echo "For each series: converting the series into a 3D nifti file oriented to match FSL's MNI152 template:"
echo ""
#for seriesNumber in ${seriesList}; do
      echo ""
      echo "############### Source data for T1 COG.C.${participantNumber}.anat.nii : ###############"
      echo "LOCATION  : ${sourceParentDir}"
      echo -n "FILE COUNT: "
      ls -1 ${sourceParentDir}/COG.C.${participantNumber}.anat.nii | wc -l
      echo "If that's the expected file count for the series, hit "
      echo -n "Enter to continue. (or CTRL-C to quit)"
      read
      echo ""
      echo "Creating .bxh metafile for COG.C.${participantNumber}.anat.nii ..."
      echo ""
      analyze2bxh ${sourceParentDir}/COG.C.${participantNumber}.anat.nii ${tempDir}/${participant}-T1.bxh
      echo ""
      echo "...done."
      echo ""
      echo "Creating new nifti volume for ${participant}-T1.bxh ..."
      echo ""
      bxh2analyze --nii -b -s ${tempDir}/${participant}-T1.bxh ${tempDir}/${participant}-T1
      echo ""
      echo "...done."
      echo ""
      echo "Reorienting ${participant}-T1.nii nifti volume to match FSL's MNI 152 template..."
      echo ""
      fslreorient2std ${tempDir}/${participant}-T1.nii ${tempDir}/${participant}_MNI
      echo ""
      echo "...done."
      echo ""
#done
 
ls -l ${tempDir}
echo ""
 
 
#############################################################################
# STEP 5: Inspect 3D images using FSLVIEW before moving on to generating the
# any QC reports.
#
echo ""
echo "Now opening fslview to confirm that each reoriented _MNI volume has"
echo "orientation consistent with the MNI152 template..."
fslview ${tempDir}/*_MNI* &
fslview ${FSLDIR}/data/standard/MNI152_T1_1mm.nii.gz &
 
echo ""
echo "If you are happy with what you seen in fslview, hit "
echo -n "Enter to continue. (or CTRL-C to quit)"
read
 
 
#############################################################################
# STEP 6: Generate a quality control report
#
# (just a place holder: at the moment we don't generate an automated T1 quality
# control report)

 
 
#############################################################################
# STEP 7: cleaning up
#

echo ""
echo ""
echo "If you are happy with the conversion, copy the output files"
echo "from the temporary ${tempDir} to your project folder. "
echo "Something like:"
echo ""
 
echo "mkdir -p /data/birc/Atlanta/${projectName}/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/${participant}/${session}/${sequences}"
echo "cp ${tempDir}/*.nii* /data/birc/Atlanta/${projectName}/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/${participant}/${session}/${sequences}"
echo "cp ${tempDir}/*.bxh  /data/birc/Atlanta/${projectName}/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/${participant}/${session}/${sequences}"
echo ""
echo "...then the last step is for you to delete your temporary directory ${tempDir} ."
echo ""
du -sh ${tempDir}
#tree -L 1 ${tempDir}
echo ""
echo ""
                       
