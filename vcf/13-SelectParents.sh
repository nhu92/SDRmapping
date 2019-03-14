#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua_SelectParents
#$ -q omni
#$ -o log/13/$JOB_NAME.o$JOB_ID
#$ -e log/13/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

source ~/.bashrc
gatk SelectVariants \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -V ../output/SE.genotype.snp.filterPASSED_DPfilterNoCall.vcf \
    --exclude-filtered TRUE \
    --max-nocall-fraction 0.25 \
    --sample-name parent.list \
    -O ../output/SE.genotype.snp.filterPASSED_DPfilterNoCall.parents.vcf; whenisover
