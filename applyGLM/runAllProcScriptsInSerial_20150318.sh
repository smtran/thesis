#!/bin/sh
#script to execute 300 line proc script in serial 03/18/2015.

cd /data/birc/Atlanta/tranThesis/03.derivedData/applyGLM/batch-20150313173303/

# currently excluding language session 25
for participant in 010 012 014 020 021 022 023 027 028 029 031 033 035 036 038 039 041 044 046 049 052 053 055 056 058 062 065 066 067 070 074 076 079; do

		tcsh -xef proc.MA${participant}.language.onsetsBlock |& tee output.proc.MA${participant}.language.onsetsBlock
done

# currently excluding motor session 38 
# no sessions for motor 35, 49, and 55. 
for participant in 010 012 014 020 021 022 023 025 027 028 029 031 033 036 038 039 041 044 046 052 053 056 058 062 065 066 067 070 074 076 079; do

		tcsh -xef proc.MA${participant}.motor.onsetsBlock |& tee output.proc.MA${participant}.motor.onsetsBlock
done
