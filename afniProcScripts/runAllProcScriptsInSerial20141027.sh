#!/bin/sh
#script to execute 300 line proc script in serial 10/27/2014

cd ${HOME}/temp/batch-tranThesis-20141027171752/

for participant in 001 002 007 010 012 014 020 021 022 023 025 027 028 029 031 033 035 036 038 039 041 044 046 049 052 053 055 056 058 062 065 066 067 070 074 076 079; do
	for task in language motor; do

		tcsh -xef proc.MA${participant}.${task}.onsetsBlock |& tee output.proc.MA${participant}.${task}.onsetsBlock
	done
done
