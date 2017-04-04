#!/usr/bin/env Python3

#################################################################################################
#This script converts FASTQ files to FASTA files.

#Usage: python3 fq2fa.py infile outfile 

#Written by Andrew D. Sweet
#################################################################################################


from Bio import SeqIO
import sys

input = open(sys.argv[1])
output = open(sys.argv[2],'w')

SeqIO.convert(input, 'fastq', output, 'fasta')