#!/bin/bash

# created 2/22/2015 and modified on 5/04/15 to run FIX on two participants who were previously excluded due to poor registration in Melodic.  


# for LANGUAGE sessions. 
		
/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/language/MA025_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m



# for REST sessions 

/opt/fix/fix /data/birc/Atlanta/tranThesis/03.derivedData/denoiseFIX/rest/MA049_preprocessMELODIC.ica/ /opt/fix/training_files/Standard.RData 20 -m

