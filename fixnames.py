#!/usr/bin/env python3

####################################################################################################
# These scripts change the FASTA headers in the locus files from sepfiles.pl by removing the locus 
# names (>SAMPLE_NAME.LOCUS to >SAMPLE_NAME). As a result, all sequences from the same individual 
# will have the same FASTA header. This is necessary for creating concatenated alignments or 
# summarizing gene trees.

# Run with fixnamesloop.sh for multiple FASTA files.

# Written by Andrew D. Sweet
####################################################################################################


import sys
import re

input = open(sys.argv[1])
output = open(sys.argv[2],'w')

for line in input:
	x = re.sub(r'^>(\S+).PHUM\d+.\S+', '>' + r'\1', line)
	output.write(x)