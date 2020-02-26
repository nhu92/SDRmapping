# Post-beagle-haplotype phasing
# Feb. 03, 2020
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
Argparse.add_argument("-p", "--PHYLO", action='store_true', help = "Add this argument if result is used for phylogeny construction. This option will reduce the size of data and only output alletic data.")
argv = vars(Argparse.parse_args())

# read fasta
if argv["PHYLO"] == False:
	for record in SeqIO.parse(argv["FASTA"], "fasta"):	
		#print(record.id)
		#print(record.seq)
		#print(len(record))
		temp = 0

# extract Chr/range
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

# formating and split columns (pos, ref, alt, idv_col)
format1_beagle = beagleout.drop(["#CHROM","ID","QUAL","FILTER","INFO","FORMAT"], axis=1) 
# print(format1_beagle)
# keep col 2,4,5,10+(as test)

# new table structuring (pos, idv_col[hap1][hap2] (split by |))
# prepare for loop

rowNum = format1_beagle["POS"].count()
colNum = format1_beagle.iloc[0].count()
indv_list = fields[9:]
# if output form is for phylogeny, then simplify input to save time and resources.
if argv["PHYLO"] == True:
	haplotype_seq1 = [""] * argv["POPSIZE"]
	haplotype_seq2 = [""] * argv["POPSIZE"]
else:
	haplotype_seq1 = [record.seq] * argv["POPSIZE"]
	haplotype_seq2 = [record.seq] * argv["POPSIZE"]
# double loop: out: visit each site; in: visit each indv_list
for position in range(0,rowNum):
	pos = format1_beagle.iat[position,0]
	ref = format1_beagle.iat[position,1]
	alt = format1_beagle.iat[position,2]
	hap = ["","","",""]
	# assigning alleles (multi alt judgement)
	hap[0] = ref
	if alt.find(",")==-1:
		hap[1] = alt
		hap[2] = alt
	elif len(alt.split(","))==2:
		hap[1] = alt.split(",")[0]
		hap[2] = alt.split(",")[1]
	elif len(alt.split(","))==3:
		hap[1] = alt.split(",")[0]
		hap[2] = alt.split(",")[1]
		hap[3] = alt.split(",")[2]
	# print(str(format1_beagle.iat[position,0]), end = "\t"),
	flag_geno = 0
	
	# -p option: if just for phylogeny constructions - no need to get fasta file to replace
	if argv["PHYLO"] == True:
		for genotype in indv_list:
			phase = format1_beagle.iloc[position].at[genotype] 
			phase_list = phase.split("|")
			
			
			# replace fasta based on haplotype table
			phase_split = [hap[int(phase_list[0])], hap[int(phase_list[1])]]
			haplotype_seq1[flag_geno] = haplotype_seq1[flag_geno] + phase_split[0]
			haplotype_seq2[flag_geno] = haplotype_seq2[flag_geno] + phase_split[1]
			flag_geno += 1
	
	# -p option missing: get fasta file and replace the alleles to it. result is for population genetics 
	else:
		for genotype in indv_list:
			phase = format1_beagle.iloc[position].at[genotype] 
			phase_list = phase.split("|")
			phase_out = hap[int(phase_list[0])] + "|" + hap[int(phase_list[1])]
			# print(phase_out, end = "\t")
			
			# replace fasta based on haplotype table
			phase_split = [hap[int(phase_list[0])], hap[int(phase_list[1])]]
			haplotype_seq1[flag_geno] = haplotype_seq1[flag_geno][:pos-1] + phase_split[0] + haplotype_seq1[flag_geno][pos:]
			haplotype_seq2[flag_geno] = haplotype_seq2[flag_geno][:pos-1] + phase_split[1] + haplotype_seq2[flag_geno][pos:]
			# print(record.seq[:pos] + phase_split[0] + record.seq[pos + 1:])
			flag_geno += 1
		# print("\n", end = "")

# output phasing fasta
for idx in range(0,argv["POPSIZE"]):
	print(">" + indv_list[idx]+ "_hap1")
	print(haplotype_seq1[idx],"\n")
	print(">" + indv_list[idx]+ "_hap2")
	print(haplotype_seq2[idx],"\n")
	











