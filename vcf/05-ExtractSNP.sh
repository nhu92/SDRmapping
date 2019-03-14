#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua-extrSNP
#$ -q omni
#$ -o log/05/$JOB_NAME.o$JOB_ID
#$ -e log/05/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

gatk --java-options "-Xmx5g -Xms5g" SelectVariants \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -O ../output/SE.genotype.snp.vcf \
    --select-type SNP \
    -V ../output/SE.genotype.vcf
