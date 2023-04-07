#!/bin/bash
#SBATCH -c 16
#SBATCH --mem=4G
#SBATCH -t 2:40:00
#SBATCH -p priority
#SBATCH -o alignment_job_%A.out

echo 'mode =' $1
echo 'ref =' $2
echo 'dir=' $3
echo 'infile=' $4
echo 'outfile=' $5

minimap2 -aY --eqx -x $1 -t 16 --sam-hit-only --secondary=no $2 $3/$4 > $3/$5.sam
samtools sort -@16 -o $3/$5.bam $3/$5.sam
samtools index -@16 $3/$5.bam
samtools view -@16 -c $3/$5.bam
#--secondary=no
#samtools view -h -b -F 2308 -@16 $3/$5.bam > $3/$5_pri.bam
#samtools view -@16 -c $3/$5_pri.bam
#samtools index -@16 $3/$5_pri.bam
#minimap2 -aY --eqx -x $1 -t 16 -k11 -n1 -m20 -s20 --sam-hit-only --secondary=no $2 $3/$4 > $3/$5.sam

