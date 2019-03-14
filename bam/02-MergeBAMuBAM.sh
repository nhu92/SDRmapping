#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -t 1-97:1
#$ -N sexigua-merge-qc
#$ -q omni
#$ -e log/02/$JOB_NAME.e$JOB_ID.$TASK_ID
#$ -o log/02/$JOB_NAME.o$JOB_ID.$TASK_ID
#$ -pe sm 16
#$ -P quanah

prefixNum="$SGE_TASK_ID"
prefixNumP="$prefixNum"p
prefix=`sed -n "$prefixNumP" namelist.list`

source ~/.bashrc
gatk \
      MergeBamAlignment \
      --VALIDATION_STRINGENCY SILENT \
      --EXPECTED_ORIENTATIONS FR \
      --ATTRIBUTES_TO_RETAIN X0 \
      --ALIGNED_BAM ../../output/aligned/"$prefix".aligned.bam \
      --UNMAPPED_BAM ../../raw/ubam/"$prefix".unmapped.bam \
      --OUTPUT ../../output/merged/"$prefix".merged.bam \
      --REFERENCE_SEQUENCE ../../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta \
      --PAIRED_RUN true \
      --SORT_ORDER 'unsorted' \
      --IS_BISULFITE_SEQUENCE false \
      --ALIGNED_READS_ONLY false \
      --CLIP_ADAPTERS false \
      --MAX_RECORDS_IN_RAM 2000000 \
      --ADD_MATE_CIGAR true \
      --MAX_INSERTIONS_OR_DELETIONS -1 \
      --PRIMARY_ALIGNMENT_STRATEGY MostDistant \
      --PROGRAM_RECORD_ID 'bwamem' \
      --PROGRAM_GROUP_VERSION '0.7.17-r1188' \
      --PROGRAM_GROUP_COMMAND_LINE 'bwa mem -K 100000000 -p -v 3 -t 10 -Y ../../raw/ref/Salix_purpurea_var_94006.mainGenome.fasta /dev/stdin -' \
      --PROGRAM_GROUP_NAME 'bwamem' \
      --UNMAPPED_READ_STRATEGY COPY_TO_TAG \
      --ALIGNER_PROPER_PAIR_FLAGS true \
      --UNMAP_CONTAMINANT_READS true; whenisover
