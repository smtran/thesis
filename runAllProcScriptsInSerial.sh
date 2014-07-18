#!/bin/sh
#
# A simple loop to execute proc scripts in serial for a bunch of participants
# so you don't have to sit around launching one after the other. This assumes,
# of course, that you already used your afni_proc script to create each of
# these proc scripts.

for participant in AF_02 AF_03 AF_04; do
	tcsh -xef proc.${participant} |& tee output.proc.${participant}
done
