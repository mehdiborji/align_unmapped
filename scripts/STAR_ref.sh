#!/bin/bash

#SBATCH -c 16
#SBATCH --mem=32G
#SBATCH -t 1:25:00
#SBATCH -p priority
#SBATCH -o alignment_job_%A.out

ref_fasta=$1
genome_dir=$2

echo $ref_fasta
echo $genome_dir

STAR \
--runMode genomeGenerate \
--runThreadN 16 \
--genomeSAindexNbases 5 \
--genomeDir $2 \
--genomeFastaFiles $1

#--genomeSAindexNbases 6 \
#--genomeChrBinNbits 7 \
#--limitGenomeGenerateRAM 92000000000
