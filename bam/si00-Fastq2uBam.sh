#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua-alignment-qc
#$ -q omni
#$ -o log/00/$JOB_NAME.o$JOB_ID.$TASK_ID
#$ -e log/00/$JOB_NAME.e$JOB_ID.$TASK_ID
#$ -pe sm 1
#$ -P quanah

gatk FastqToSam --java-options "-Xmx8G" \
    --FASTQ ../../raw/SE916F_R1.fastq \
    --FASTQ2 ../../raw/SE916F_R2.fastq \
    --OUTPUT ../../raw/ubam/SE916F.unmapped.bam \
    --READ_GROUP_NAME Salix_exigua_SDR \
    --SAMPLE_NAME "$prefix" \
    --LIBRARY_NAME NEBNext-"$prefix" \
    --PLATFORM_UNIT HT23LBBXX.6.1101 \
    --PLATFORM illumina \
    --SEQUENCING_CENTER OMRF \
    --RUN_DATE 2019-03-10T08:55:00+0500
