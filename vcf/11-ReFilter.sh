#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua_ReFilter
#$ -q omni
#$ -o log/11/$JOB_NAME.o$JOB_ID
#$ -e log/11/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

source ~/.bashrc
gatk VariantFiltration \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -V ../output/SE.genotype.snp.filterPASSED.vcf \
    --genotype-filter-expression "DP < 6 || DP > 100" \
    --genotype-filter-name "DP_6-100" \
    -O ../output/SE.genotype.snp.filterPASSED_DPfilter.vcf; whenisover
