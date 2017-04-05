#!/usr/bin/bash

#################################################################################################
# This script runs fixnames.py for multiple FASTA files. 


# Written by Andrew D. Sweet
#################################################################################################


for myfile in *.fasta; do
	python3 fixnames.py $myfile $myfile.renamed.fasta; # CHANGE ACCORDING TO FILE NAMES
done;

mkdir RENAMED;
mv *.renamed.fasta RENAMED;