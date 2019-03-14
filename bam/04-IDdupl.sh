#!/bin/sh
#$ -V
#$ -cwd
#$ -t 1-97:1
#$ -S /bin/bash
#$ -N sexigua-dedup-qc
#$ -q omni
#$ -o log/04/$JOB_NAME.o$JOB_ID.$TASK_ID
#$ -e log/04/$JOB_NAME.e$JOB_ID.$TASK_ID
#$ -pe sm 6
#$ -P quanah

prefixNum="$SGE_TASK_ID"
prefixNumP="$prefixNum"p
prefix=`sed -n "$prefixNumP" namelist.list`

source ~/.bashrc
gatk --java-options "-Dsamjdk.compression_level=5 -Xms4000m" \
      MarkDuplicates \
      --INPUT ../../output/sorted/"$prefix".sorted.bam \
      --OUTPUT ../../output/dedup/"$prefix".dedup.bam \
      --METRICS_FILE "$prefix".dedup.metrics \
      --VALIDATION_STRINGENCY SILENT \
      --OPTICAL_DUPLICATE_PIXEL_DISTANCE 2500 \
      --REMOVE_DUPLICATES true \
      --ASSUME_SORT_ORDER 'coordinate' \
      --CREATE_INDEX true \
      --CREATE_MD5_FILE true; whenisover
