#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -t 1-97:1
#$ -N sexigua-sortnfix-qc
#$ -q omni
#$ -e log/03/$JOB_NAME.e$JOB_ID.$TASK_ID
#$ -o log/03/$JOB_NAME.o$JOB_ID.$TASK_ID
#$ -pe sm 16
#$ -P quanah

prefixNum="$SGE_TASK_ID"
prefixNumP="$prefixNum"p
prefix=`sed -n "$prefixNumP" namelist.list`

source ~/.bashrc
gatk --java-options "-Dsamjdk.compression_level=5 -Xms4000m" SortSam \
  --INPUT ../../output/merged/"$prefix".merged.bam \
  --OUTPUT /dev/stdout \
  --SORT_ORDER 'coordinate' \
  --CREATE_INDEX false \
  --CREATE_MD5_FILE false \
  | \
  gatk --java-options "-Dsamjdk.compression_level=5 -Xms500m" \
  SetNmAndUqTags \
  --INPUT /dev/stdin \
  --OUTPUT ../../output/sorted/"$prefix".sorted.bam \
  --CREATE_INDEX true \
  --CREATE_MD5_FILE true \
  --REFERENCE_SEQUENCE ../../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta; whenisover
