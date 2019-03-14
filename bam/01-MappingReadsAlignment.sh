#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -t 1-97:1
#$ -N sexigua-alignment-qc
#$ -q omni
#$ -e log/01/$JOB_NAME.e$JOB_ID.$TASK_ID
#$ -o log/01/$JOB_NAME.o$JOB_ID.$TASK_ID
#$ -pe sm 16
#$ -P quanah

prefixNum="$SGE_TASK_ID"
prefixNumP="$prefixNum"p
prefix=`sed -n "$prefixNumP" namelist.list`

gatk --java-options "-Dsamjdk.compression_level=5 -Xms3000m" SamToFastq \
    --INPUT ../../raw/ubam/"$prefix".unmapped.bam \
    --FASTQ /dev/stdout \
    --INTERLEAVE true \
    --NON_PF true \
    | \
    bwa mem -K 100000000 -p -v 3 -t 16 -Y ../../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
    /dev/stdin - \
    | \
    samtools view -1 - > ../../output/aligned/"$prefix".aligned.bam
