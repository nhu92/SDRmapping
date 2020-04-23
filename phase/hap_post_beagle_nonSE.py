# Post-beagle-haplotype phasing/Non-SEspecies2SE
# Mar. 03, 2020
# Nan Hu

# import and args
import pandas as pd
import argparse
from Bio import SeqIO

# args include ()
Argparse = argparse.ArgumentParser()
Argparse.add_argument("-v", "--VCF", required = True, help = "VCF output from BEAGLE5, contains segregating sites positions in Salix exigua.")
Argparse.add_argument("-f", "--FASTA", required = True, help = "Input FASTA file for extract alleles.")
Argparse.add_argument("-N", "--POPSIZE", required = True, type = int, help = "Number of population size. If contains 2 haplotypes, Ne should be doubled.")
argv = vars(Argparse.parse_args())

# read fasta
seqID = [""] * argv["POPSIZE"]
sequence = [""] * argv["POPSIZE"]
flag = 0
for record in SeqIO.parse(argv["FASTA"], "fasta"):	
	seqID[flag] = record.id
	sequence[flag] = record.seq
	flag += 1

# read beagle output
flag = 0
f = open(argv["VCF"] + ".tmp1", "wt")
for line in open(argv["VCF"]):
	line=line.strip('\n')
	if flag == 9:
		fields = line.split('\t')
	if flag > 9:
		print(line, file = f)
	flag += 1
f.close()
beagleout = pd.read_csv(argv["VCF"]+ ".tmp1",names = fields, sep = '\t')

haplotype_seq = [""] * argv["POPSIZE"]
SNPpos = beagleout["POS"]
for idx in range(0,argv["POPSIZE"]):
	for pos in SNPpos:
		haplotype_seq[idx] = haplotype_seq[idx] + sequence[idx][pos-1]

for idx in range(0,argv["POPSIZE"]):
	print(">" + seqID[idx])
	print(haplotype_seq[idx],"\n")
