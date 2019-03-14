#!/bin/sh
#$ -V
#$ -cwd
#$ -t 1-347:1
#$ -S /bin/bash
#$ -N HC_SE_RENAME
#$ -o log/01/$JOB_NAME.o$JOB_ID
#$ -e log/01/$JOB_NAME.e$JOB_ID
#$ -q omni
#$ -pe sm 1
#$ -P quanah

prefixNum="$SGE_TASK_ID"
prefixNumP="$prefixNum"p
prefix=`sed -n "$prefixNumP" chromosome.txt`

gatk HaplotypeCaller -R ../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta -L "$prefix" -I ../output/dedup/RENAME.dedup.bam -ERC GVCF -O ../output/vcf/RENAME/RENAME."$prefix".g.vcf > ../output/vcf/RENAME/RENAME."$prefix".err 2>&1

