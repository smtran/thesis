#!/bin/sh
#script to execute 300 line proc script in serial 11/05/2014

cd ${HOME}/temp/batch-tranThesis-20141105180255/

for participant in 010 012 014 020 021; do
	for task in language motor; do

		tcsh -xef proc.MA${participant}.${task}.onsetsBlock |& tee output.proc.MA${participant}.${task}.onsetsBlock
	done
done
