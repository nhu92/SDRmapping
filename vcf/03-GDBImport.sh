#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N sexigua_GDB
#$ -q omni
#$ -o log/03/$JOB_NAME.o$JOB_ID
#$ -e log/03/$JOB_NAME.e$JOB_ID
#$ -pe sm 1
#$ -P quanah

source ~/.bashrc
gatk --java-options "-Xmx4g -Xms4g" GenomicsDBImport \
    --sample-name-map ./SE.sample_map \
    --genomicsdb-workspace-path ../output/genoDB \
    -L chromosome.list; whenisover


