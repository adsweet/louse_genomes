#!/usr/bin/env perl

#################################################################################################
# This script combines the sequences from the top hit of the best file for each locus (assembled 
# from aTRAM) into a singe file.
# The resulting file can be used as a reference set (e.g. for Bowtie2)

# Written by Bret M. Boyd
#################################################################################################

use strict;
use warnings;

`ls -lh >allmyfiles.txt`

open IN, "<allmyfiles.txt";
open OUT, ">OUTFILE.fasta";

while (<IN>){
    if (/(PHUM\d+.Pheme)(.5.26.2015.7.out.best.fasta.two.fasta)/){ # CHANGE THIS ACCORDING TO THE FILE NAMES 
	my $name = $1;
	my $stuff = $2;
	my $wholename = $name.$stuff;
	#print "$wholename\n";
	open SEQ, "<$wholename";
	while (<SEQ>){
	    if (/^>\S+/){
		print OUT ">$name\n";
	    }
	    else {
		print OUT "$_";
	    }
	}
	close SEQ;
    }
}
