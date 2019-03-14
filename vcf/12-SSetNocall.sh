#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua_SetNocall
#$ -q omni
#$ -o log/12/$JOB_NAME.o$JOB_ID
#$ -e log/12/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

source ~/.bashrc
gatk SelectVariants \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -V ../output/SE.genotype.snp.filterPASSED_DPfilter.vcf \
    --set-filtered-gt-to-nocall TRUE \
    -O ../output/SE.genotype.snp.filterPASSED_DPfilterNoCall.vcf; whenisover
