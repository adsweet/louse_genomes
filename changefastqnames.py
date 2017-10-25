#!/usr/bin/env Python3

#################################################################################################
# This script changes the FASTQ header names of the output files from the mapping pipeline 
# (reference_mapping_pipeline_script.sh).

# Usage: python3 changefastqnames.py

# Written by Andrew D. Sweet
#################################################################################################

import re
import glob

for file in glob.glob('*.samtools.consensus.fq'): # Change this depending on file extension
	name = re.sub(r'(\S+).samtools.consensus.fq',r'\1',file) # Change this depending on file extension
	with open(name + '.renamed.samtools.consensus.fq', 'w') as out:
		with open(file, 'r') as input:
			for line in input:
				x = re.sub(r'^\@(PHUM\d+\.Pheme)',r'@' + name + r'.\1',line) # Change the regex according to the headers
				out.write(x)




