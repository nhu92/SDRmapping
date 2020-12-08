# SDRmapping workflow for Salix exigua 
## (using Fst analysis)

Nan Hu
Department of Biological Sciences
Texas Tech University
---
#### Folders:
**bam** - reads mapping
  codes for mapping sequence capture reads to reference genome
**vcf** - variants calling
  1. codes for calling SNPs from mapped population
  2. filter the vcf files with criteria screened from reads status distribution
  3. fst analysis mapping out the SDR region
**phase** - phasing X and Y haplotype
  1. bash scripts in using BEAGLE 5.0 to phase haplotypes
  2. python scripts to extract haplotypes
  3. phylogeny reconstruction of X and Y haplotypes
