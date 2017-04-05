#!usr/bin/env perl

#################################################################################################
# This script separates out loci into separate files
# Written by Bret M. Boyd
#################################################################################################

use strict;
use warnings;

my @namearray=();
my %namehash=();
my $count=0;

open FH, "<INPUT FILE"; # FASTA file, perhaps the output from fqtofasta.pl
while (<FH>) {
        if (/^>\S+.(PHUM\d+)\S+/) {
                my $name=$1;
                if (! exists $namehash{$name}) {  
                        $namehash{$name}=1;
                        push @namearray, $name;
                        $count++;
                }
        }
}
close FH;
print "there are $count ortholog groups\n";

for my $name (@namearray) {
        open OUT, ">$name.ortholog.group.fa";
        open IN, "<INPUT FILE";
        my $flag=0;
        while (<IN>) {
                if ($flag == 1 ) { print OUT; $flag=0; }
                if (/^>\S+$name\./) {
                        print OUT;
                        $flag=1;
                }
        }
}
