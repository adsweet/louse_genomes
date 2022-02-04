#!/usr/local python

## Script to remove predicted genes based on AED score
## Andrew D. Sweet

from Bio import SeqIO
import sys
import re

records = []

for seq in SeqIO.parse(sys.argv[1], "fasta"):
	header = seq.description
	aed = re.search(r' AED:(\d\.\d+)', header)
	good = aed.group(1)
	if float(good) <= 0.5:
		print(header)
		records.append(seq)
SeqIO.write(records, sys.argv[2], "fasta")