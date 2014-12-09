#!/bin/sh
#script to execute 300 line proc script in serial 11/05/2014
#modified 12/04/2014 to only include 8 participants with misaligned EPI and T1

cd /data/birc/Atlanta/tranThesis/afniProcScriptOutput/reexecutionOfMisalignedParticipants20141204/

for participant in 010 022 031 036 052 056 067 074; do

	tcsh -xef proc.MA${participant}.motor.onsetsBlock |& tee output.proc.MA${participant}.motor.onsetsBlock
	done
done
