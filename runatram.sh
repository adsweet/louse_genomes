#!/usr/bin/sh

#################################################################################################
# This script will run aTRAM; the results from this run are used as reference loci for 
# reference-mapping of closely related, low-coverage genome libraries.
# Written by Andrew D. Sweet and Julie M. Allen
#################################################################################################


lib='LIBNAME.DB'; # define the library name
cd REF PATH; # cd into the directory with the reference sequences

for gene in *.fasta; do
	echo $gene;
perl PATHTOATRAM/aTRAM.pl -target PATH_TO_REFERENCES/$gene  -reads PATH_TO_ATRAM_LIB/$lib  -iterations 3  -fraction 1  -assembler Abyss -k 31  -out PATH_TO_ATRAM_OUT_DIRECTORY/$gene.$lib.out;
done;



#SELECT THE TOP HIT FROM THE BEST FILES FROM EACH ASSEMBLED LOCUS AND MOVE THEM TO NEW FILES
cd OUT PATH # cd into the aTRAM output directory
for REF in *.best.fasta; do
head -2 $REF > $REF.top.fasta;
done
