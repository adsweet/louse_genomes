#!/usr/bin/env Python3

#################################################################################################
#This script changes the FASTQ header names of the output files from the mapping pipeline 
#(reference_mapping_pipeline_script.sh).

#Usage: python3 changefastqnames.py infile outfile sample_name 

#Written by Andrew D. Sweet
#################################################################################################

import sys
import re

input = open(sys.argv[1])
out = open(sys.argv[2], 'w')
name = sys.argv[3]

for line in input:
	x = re.sub(r'^\@(PHUM\d+\.Pheme)',r'@' + name + r'.\1',line) #Change the regex according to the headers
	out.write(x)




