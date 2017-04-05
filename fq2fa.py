#!/usr/bin/env Python3

#################################################################################################
# This script converts FASTQ files to FASTA files.

# Usage: python3 fq2fa.py infile outfile 

# Written by Andrew D. Sweet
#################################################################################################


from Bio import SeqIO
import sys
import os

os.system("cat *.fq >all_fastq.fq")

input = open('all_fastq.fq')
output = open(sys.argv[1],'w')

SeqIO.convert(input, 'fastq', output, 'fasta')
