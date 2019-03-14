#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua_DPtable
#$ -q omni
#$ -o log/10/$JOB_NAME.o$JOB_ID
#$ -e log/10/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

gatk VariantsToTable \
     -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
     -V ../output/SE.genotype.vcf \
     -F CHROM -F POS -GF GT -GF DP \
     -O ../output/SE.genotype.DP.table
