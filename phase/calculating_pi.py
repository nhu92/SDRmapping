# Calculating pairwise pi over X/Y
# Feb. 17, 2020
# Nan Hu

# import and args
import pandas as pd
import argparse
from Bio import SeqIO

# args include ()
Argparse = argparse.ArgumentParser()
Argparse.add_argument("-v", "--VCF", required = True, help = "VCF output from BEAGLE5.")
Argparse.add_argument("-f", "--FASTA", required = True, help = "Input FASTA file for replacing alleles.")
Argparse.add_argument("-N", "--POPSIZE", required = True, type = int, help = "Number of population size.")
argv = vars(Argparse.parse_args())
# read sequences

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

seqID = [""] * argv["POPSIZE"]
sequence = [""] * argv["POPSIZE"]
flag = 0
for record in SeqIO.parse(argv["FASTA"], "fasta"):	
	seqID[flag] = record.id
	sequence[flag] = record.seq
	flag += 1

# Only calc for polymorphic sites

SNPpos = beagleout["POS"]

sum_pi = 0 # set a total pairwise difference var

# 3 loops. Out: visit each pos; Mid: visit all idvs; In: calc pairwise pi
for pos in SNPpos:
	for idx in range(0,argv["POPSIZE"]):
		for idx2 in range(idx+1,argv["POPSIZE"]):
			if sequence[idx][pos-1] != sequence[idx2][pos-1]:
				sum_pi +=1
	pi_diversity = sum_pi/(argv["POPSIZE"]*(argv["POPSIZE"]-1)/2)
	print(pos,pi_diversity)
	sum_pi = 0


