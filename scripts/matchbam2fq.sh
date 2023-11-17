#!/bin/bash
#SBATCH -c 16
#SBATCH --mem=32G
#SBATCH -t 0:10:00
#SBATCH -p priority
#SBATCH -o matchbam2fastq_job_%A.out

samtools index -@16 $1.bam
samtools view -@16 -f 4 -b -h $1.bam > $1_unmapped.bam
samtools index -@16 $1_unmapped.bam
samtools bam2fq -@16 $1_unmapped.bam > $1_unmapped.fastq
#pigz $1_unmapped.fastq