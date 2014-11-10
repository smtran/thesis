#!/bin/sh
#script to execute 300 line proc script in serial 11/05/2014

cd /data/birc/Atlanta/tranThesis/afniProcScriptOutput/batch-tranThesis-20141105180255/

for participant in 066 067 070 074 076 079; do
	for task in language motor; do

		tcsh -xef proc.MA${participant}.${task}.onsetsBlock |& tee output.proc.MA${participant}.${task}.onsetsBlock
	done
done
