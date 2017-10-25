#!/usr/bin/env Python3

#################################################################################################
# This script converts FASTQ files to FASTA files.

# Usage: python3 fq2fa.py

# Written by Andrew D. Sweet
#################################################################################################


from Bio import SeqIO
import sys
import os

os.system("cat *.fq >all_fastq.fq")

with open('all_fasta.fasta', 'w') as output:
	with open('all_fastq.fq', 'r') as input:
		for record in SeqIO.parse(input, "fastq"):
			sequence = str(record.seq)
			output.write('>' + record.id + '\n' + sequence + '\n')
