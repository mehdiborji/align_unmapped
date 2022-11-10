#!/bin/bash

#SBATCH -c 16
#SBATCH --mem=32G
#SBATCH -t 3:25:00
#SBATCH -p priority
#SBATCH -o alignment_job_%A.out

genome_dir=$1
input_fastq=$2
out_name=$3

echo $input_fastq
echo $genome_dir
echo $out_name

STAR \
--runThreadN 16 \
--readFilesIn $input_fastq \
--alignIntronMax 1 \
--outFilterScoreMin 30 \
--genomeDir $genome_dir \
--outFileNamePrefix $out_name \
--readFilesCommand zcat

#--alignIntronMax 1 \
#--readMapNumber $5 \
#--outSAMmode NoQS \
#--outSAMattributes AS \
#--outFilterMultimapNmax 50 \

samtools sort -@16 -o "$out_name".bam "$out_name"Aligned.out.sam
samtools index -@16 "$out_name".bam
samtools view -h -b -F 2308 -@16 "$out_name".bam > "$out_name"_pri.bam
samtools index -@16 "$out_name"_pri.bam

#rm "$out_name"*out*

