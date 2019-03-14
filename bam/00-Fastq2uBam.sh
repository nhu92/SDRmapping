#!/bin/sh
#$ -V
#$ -cwd
#$ -t 1-96:1
#$ -S /bin/bash
#$ -N sexigua-alignment-qc
#$ -q omni
#$ -o log/00/$JOB_NAME.o$JOB_ID.$TASK_ID
#$ -e log/00/$JOB_NAME.e$JOB_ID.$TASK_ID
#$ -pe sm 1
#$ -P quanah

prefixNum="$SGE_TASK_ID"
prefixNumP="$prefixNum"p
prefix=`sed -n "$prefixNumP" allnames-short.txt`

gatk FastqToSam --java-options "-Xmx8G" \
    --FASTQ reads/"$prefix"_R1_001.fastq \
    --FASTQ2 reads/"$prefix"_R2_001.fastq \
    --OUTPUT uBAM/SN"$prefix".unmapped.bam \
    --READ_GROUP_NAME Salix_nigra_SDR \
    --SAMPLE_NAME "$prefix" \
    --LIBRARY_NAME NEBNext-"$prefix" \
    --PLATFORM_UNIT HT23LBBXX.6.1101 \
    --PLATFORM illumina \
    --SEQUENCING_CENTER OMRF \
    --RUN_DATE 2018-03-12T08:55:00+0500
