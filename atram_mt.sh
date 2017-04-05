#!usr/bin/bash

#################################################################################################
# This script will run aTRAM to assemble mitochondrial genes.
# Written by Andrew D. Sweet and Bret M. Boyd
#################################################################################################


for NUM in 0.015 0.047 0.078 0.156; do
lib='LIBRARY NAME.DB';
cd /data/physconelloides_genomes/mt_refs/; 
for ref in *.fa; do
    gene=`expr match "$ref" '.*\(\S+\)'`;
    perl PATH_TO_ATRAM/aTRAM.pl -target  PATH_TO_REFERENCE/$ref.fa -reads PATH_TO_ATRAM_LIBRARY/$taxa.DB -iterations 1 -fraction $NUM -assembler Abyss -max_processes 16 -protein -db_gencode 5 -out PATH_TO_OUTPUT_DIRECTORY/$ref.$NUM.$taxa.out;
done;
done;
