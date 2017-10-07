#!/usr/bin/bash

#################################################################################################
# This script will run Bowtie2, filter resulting sites, and produce a consensus from filtered 
# variants.
# Developed by Andrew D. Sweet, Bret M. Boyd, and Julie M. Allen
#################################################################################################



#VARIALBLES TO DEFINE BEFORE RUNNING
mylib='LIBRARY NAME';
myref='REFERENCE';
myrefpath='PATH TO REFERENCE';
mypath='PATH TO LIBRARY';

#RUN BOWTIE2
bowtie2-build $myrefpath/$myref.fa $myrefpath/$myref.Genes; # THIS ONLY NEEDS TO BE RUN ONCE PER REFERENCE SET; COMMENT OUT OTHERWISE
bowtie2 --phred33 --local -x $myrefpath/$myref.Genes -U $mypath/<READS1>,$mypath/<READS2> -S $mylib.sam; # CHANGE READS1 AND READS2 TO THE PAIRED-END READ FILES; WITHOUT TRIMMING USE -1 AND -2
samtools faidx $myrefpath/$myref.fa; # THIS ONLY NEEDS TO BE RUN ONCE PER REFERENCE SET; COMMENT OUT OTHERWISE
samtools view -bt $myrefpath/$myref.fa.fai $mylib.sam > $mylib.bam;
samtools view -b -F 4 $mylib.bam > $mylib.mapped.bam;
samtools sort $mylib.mapped.bam $mylib.mapped.sorted;

#CREATING VCF FILES AND CONSENSUS SEQUENCE
samtools mpileup -uf $myrefpath/$myref.fa $mylib.mapped.sorted.bam -d 75 -Q 28 -q 10 > $mylib.mpileup
bcftools view -cg $mylib.mpileup > $mylib.samtools.vcf;
perl <PATH>/vcfutils.pl vcf2fq $mylib.samtools.vcf > $mylib.samtools.consensus.fq; # THIS IS FOR GETTING A CONSENSUS BEFORE VCF FILTERING; CHANGE PATH TO THE VCFUTILS.PL SCRIPT
samtools depth $mylib.mapped.sorted.bam | awk '{sum+=$3; sumsq+=$3*$3} END { print "Average =",sum/NR; print "Stdev =",sqrt(sumsq/NR - (sum/NR)**2)}' >> $mylib.depth.txt; # CALCULATE AVERAGE AND STDEV DEPTH

#CREATE A PICARD .DICT FILE FOR THE REFERENCE SEQUENCE
picard-tools CreateSequenceDictionary R= $myrefpath/$myref.fa O= $myrefpath/$myref.dict # THIS ONLY NEEDS TO BE RUN ONCE PER REFERENCE SET; COMMENT OUT OTHERWISE

#REMOVE EXTRA FILES
rm $mylib.sam;
rm $mylib.mapped.bam;

#REPLACE ';;' WITH ';' IN VCF FILE
sed -i -e 's/;;/;/g' $mylib.samtools.vcf;

#FILTERING
#FILTERING VCF
java -jar PATH/GenomeAnalysisTK.jar -T VariantFiltration -R $myrefpath/$myref.fa -V $mylib.samtools.vcf --filterExpression "DP < 5.0 || DP > 150 || QUAL < 28.0" --filterName "filter2" -o $mylib.filteredDP5.vcf; # CHANGE FILTERING PARAMETERS AS NEEDED

#SELECT ONLY 'PASS' VARIANTS
java -jar PATH/GenomeAnalysisTK.jar -T SelectVariants -R $myrefpath/$myref.fa -V $mylib.filteredDP5.vcf -o $mylib.selectDP5.vcf -ef;

#CONSENSUS FROM FILTERED VARIANTS
perl PATH/vcfutils.pl vcf2fq $mylib.selectDP5.vcf > $mylib.selectDP5.consensus.fq;
