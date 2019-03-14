#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua-genotype
#$ -q omni
#$ -o log/04/$JOB_NAME.o$JOB_ID
#$ -e log/04/$JOB_NAME.e$JOB_ID
#$ -pe sm 5
#$ -P quanah

source ~/.bashrc
gatk --java-options "-Xmx5g -Xms5g" GenotypeGVCFs \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -O ../output/SE.genotype.vcf \
    -G StandardAnnotation \
    --use-new-qual-calculator \
    -V gendb://../output/genoDB
    --heterozygosity 0.015 \
    --indel-heterozygosity 0.01 \
    --stand-call-conf 30.0; whenisover
