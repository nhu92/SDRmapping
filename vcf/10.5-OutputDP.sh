for ((i=3; i<=193; i +=2)); do cut -f "$i","$((i+1))" ../output/sexigua.genotypes.DP.table | awk '$1 != "./." {print $2}' > ../output/DPs/$i.DP; done
