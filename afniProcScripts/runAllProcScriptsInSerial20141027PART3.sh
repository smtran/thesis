#!/bin/sh
#script to execute 300 line proc script in serial 11/05/2014

cd ${HOME}/temp/batch-tranThesis-20141105180255/

for participant in 029 031 033 035 036; do
	for task in language motor; do

		tcsh -xef proc.MA${participant}.${task}.onsetsBlock |& tee output.proc.MA${participant}.${task}.onsetsBlock
	done
done