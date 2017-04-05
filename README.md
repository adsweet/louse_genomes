# Scripts for working with genomic data from lice
These scripts can be used to assemble and map avian louse genomes (or other small genomes without an existing reference). The resulting loci can be used for phylogenetic analysis. Run the pipeline as follows:

## 1. Assembling reference loci set
### a. runatram.sh
This shell script will run aTRAM and select the top BLAST hit from the best file of each assembeled locus. Before running this script, make sure the read library was converted to a BLAST-formatted database with the format_sra.pl script from the aTRAM package.

### b. makeone.pl
This Perl script combines the top BLAST hits from each locus and combines them into a single file. The resulting FASTA file can be used as a reference set for reference-based mapping (e.g. with Bowtie2; see steps below).

## 2. Mapping lower-coverage genomes
### a. reference_mapping_pipeline_script.sh
This shell script will run Bowtie2, filter resulting sites, and produce a consensus from filtered variants. Before running, set the library name, reference file name, and path to all relevant directories. The filtereing parameters can be changed as needed. Output files: .bam, mapped.sorted.bam, .mpileup, .vcf (x2, from samtools and GATK), depth.txt, consensus.fq (2x, before and after GATK filtereing).

### b. changefastqnames.py
This Python script will change the header names from the consensus.fq FASTQ files. The reference_mapping_pipeline_script.sh script outputs files with the reference as the header (e.g. @LOCUS.REFERENCE_NAME), rather than the individual library names.

Usage:
```python3 changefastqnames.py input_file output_file sample_name```

### c. fq2fa.py
A basic Bio Python script to convert from FASTQ format to FASTA format. The script first concatenates all .fq files in the directory into a single file, and converts it to FASTA format.

Usage: ```python3 fq2fa.py output_fule```

### d. sepfiles.pl
This script separates each locus into its own file. These files can then be aligned with standard multiple sequence alignment software (e.g. MAFFT)

## Related scripts

### fixnames.py and fixnamesloop.sh
These scripts change the FASTA headers in alignment files by removing the locus names (>SAMPLE_NAME.LOCUS to >SAMPLE_NAME). As a result, all sequences from the same individual will have the same FASTA header. This is necessary for creating concatenated alignments or summarizing gene trees.

### atram_mt.sh
This shell script will run aTRAM to assemble loci using various library fractions. Primarily, use this script to assemble mitochondrial genes. 
