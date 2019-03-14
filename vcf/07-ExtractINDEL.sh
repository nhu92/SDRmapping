#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua-extrINDEL
#$ -q omni
#$ -o log/07/$JOB_NAME.o$JOB_ID
#$ -e log/07/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

gatk --java-options "-Xmx5g -Xms5g" SelectVariants \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -O ../output/SE.genotype.INDEL.vcf \
    --select-type INDEL \
    -V /lustre/scratch/nhu/SE_SDR_v5_w/output/SE.genotype.vcf
