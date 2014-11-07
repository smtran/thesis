#!/bin/bash
#
# created: 20130724 by stowler@gmail.com
# edited:  20140612 by stowler@gmail.com
#
# This is a short script to illustrate quality control (qc) and conversion of
# thesis motor data
# - It is currently designed for FMRI runs from a single session of scanning
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
participantNumber=001
participant=MA${participantNumber} 
session=sessA
sequences=rest 
 
#############################################################################
# STEP 1: Create the variable ${tempDir} , and assign to it the full path of a
# temporary output directory in which we'll inspect output
#
# Details: We'll start by deleting any existing version of this directory, and
# the recreating it. That avoids accidentally mixing old aborted data with your
# current QC data.
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
sourceParentDir=/data/birc/Atlanta/tranThesis/UAMS_data/UAMS_data_xferred/
 
 
#############################################################################
# STEP 3: Create the variable ${fmriSeriesList}, and assign its value: a
# space-separated list of the FMRI series you are about to QC.  
#
# Details: Per the way the original data were stored, the individual
# series are stored in folders named according to order of series acquision.
# Create the list to reflect the temporal order of acquisition. This allows the
# resulting QC data to be interpreted with the knowledge that the first run
# shown in the QC report came before the second run shown in the QC report,
# etc.
#
#
# e.g., fmriSeriesList="4 5 6 7 8 9"
#
#fmriSeriesList="Cog_epi01 Cog_epi02 Cog_epi03"
 
 
#############################################################################
# STEP 4: For each FMRI series, do three things
#
#   1) create a .bxh file containing the series' metadata (command: analyze2bxh)
#   2) create a 4D nifti file (command: bxh2analyze --nii)
#   3) reorient that 4D nifti file into gross alignment with the MNI 152 template (command: fslreorient2std)
#
 
echo ""
echo ""
echo "For each FMRI series: reformatting and reorienting input images to match FSL's MNI152 template:"
echo ""
# NB: going through the analyze2bxh -> bxh2analyze pipeline even if the source
# images were nifti from the scanner. This ensures that fslreorient2std gets a
# consistently formatted nifti regardless of the image type exported by the
# scanner. 

      echo ""
      echo "############### Source data for sequence COG.C.${participantNumber} : ###############"
      echo "LOCATION  : ${sourceParentDir}"
      echo -n "FILE COUNT: "
      ls -1 ${sourceParentDir}/COG.C.${participantNumber}.restA.nii | wc -l
      echo "If that's the expected file count for the series, hit "
      echo -n "Enter to continue. (or CTRL-C to quit)"
      read
      echo "Creating .bxh metafile for COG.C.${participantNumber}.restA.nii..."
      echo ""
      analyze2bxh ${sourceParentDir}/COG.C.${participantNumber}.restA.nii ${tempDir}/epi01.bxh
      echo ""
      echo "...done."
      echo ""
      echo "Creating new nifti volume for sequence COG.C.${participantNumber}.restA.nii"
      echo ""
      bxh2analyze --nii -b -s ${tempDir}/epi01.bxh ${tempDir}/epi01
      echo ""
      echo "...done."
      echo ""
      echo "Reorienting nifti volume to match FSL's MNI 152 template..."
      echo ""
      fslreorient2std ${tempDir}/epi01.nii ${tempDir}/epi01_MNI
      echo ""
      echo "...done."
      echo ""

 
ls -l ${tempDir}
echo ""
 
 
#############################################################################
# STEP 5: Inspect 4D images using FSLVIEW before moving on to generating the
# intensity QC reports.
#
echo ""
echo "Now opening fslview to confirm that each reoriented _MNI volume has"
echo "orientation consistent with the MNI152 template..."
fslview ${tempDir}/*_MNI* &
 
echo ""
echo "If you are happy with what you seen in fslview, hit "
echo -n "Enter to continue. (or CTRL-C to quit)"
read
 
 
#############################################################################
# STEP 6: Execute FBIRN's fmriqa_generate.pl to generate the QC report for these
# runs:
#
echo ""
echo "Creating QC report for series sequence COG.C.${participantNumber}:"
echo ""
# ...first we make a list of bxh files ordered according to their appearance in the ${fmriSeriesList} defined above:
#orderedListBXH=''
#for seriesNumber in ${fmriSeriesList}; do
#        orderedListBXH="${orderedListBXH} ${tempDir}/fmriSeries${seriesNumber}.bxh "

# ...and then we execute the command that creates qc report:
qcReportOutDir=${tempDir}/qcReport-FBIRN
# ...don't mkdir: the fmriqa_generate.pl command will create it.
fmriqa_generate.pl ${tempDir}/epi01.bxh ${qcReportOutDir}
echo ""
echo "...done."
echo ""
 
 
#############################################################################
# STEP 7: cleaning up
#
echo "To inspect the QC report just point your web browser at file://${qcReportOutDir}/index.html"
echo ""
echo "If you are happy with the conversion and QC results, copy the output files"
echo "from the temporary ${tempDir} to your project folder. "
echo "Something like:"
echo ""
 
echo "mkdir -p /data/birc/Atlanta/${projectName}/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/${participant}/${session}/${sequences}"
echo "mkdir -p /data/birc/Atlanta/${projectName}/03.derivedData/qualityControl/${participant}/${session}/${sequences}"
echo "cp ${tempDir}/*.nii* /data/birc/Atlanta/${projectName}/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/${participant}/${session}/${sequences}"
echo "cp ${tempDir}/*.bxh  /data/birc/Atlanta/${projectName}/02.collectedData-TREAT_AS_SENSITIVE/mrSourceNiftisScreened/${participant}/${session}/${sequences}"
echo "cp -r ${qcReportOutDir} /data/birc/Atlanta/${projectName}/03.derivedData/qualityControl/${participant}/${session}/${sequences}"
echo ""
echo "...then the last step is for you to delete your temporary directory ${tempDir} ."
echo ""
du -sh ${tempDir}
#tree -L 1 ${tempDir}
echo ""
echo ""
                       
