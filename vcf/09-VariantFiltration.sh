#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua_VFilter
#$ -q omni
#$ -o log/09/$JOB_NAME.o$JOB_ID
#$ -e log/09/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

source ~/.bashrc
gatk VariantFiltration \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -V ../output/SE.genotype.snp.vcf \
    --filter-expression "QUAL < 30.000 || MQ < 15.00 || SOR > 4.000 || QD < 20.000 || FS > 60.000 || MQRankSum < -10.000 || ReadPosRankSum < -2.000 || ReadPosRankSum > 2.000" \
    --filter-name "my_snp_filter" \
    -O ../output/SE.genotype.snp.filter.vcf; whenisover

