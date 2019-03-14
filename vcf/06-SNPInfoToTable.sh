#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua-SNPInfo
#$ -q omni
#$ -o log/a06/$JOB_NAME.o$JOB_ID
#$ -e log/a06/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

gatk --java-options "-Xmx5g -Xms5g" VariantsToTable \
    -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    -O ../output/SE.genotype.snp.table \
    -F CHROM -F POS -F QUAL -F QD -F DP -F MQ -F MQRankSum -F FS -F ReadPosRankSum -F SOR \
    -V /lustre/scratch/nhu/SE_SDR_v5_w/output/SE.genotype.snp.vcf
