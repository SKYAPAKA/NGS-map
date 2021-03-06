#!/bin/sh

# Script to download macaque genome, Mmul8

mkdir genomes/Mmul8
cd genomes/Mmul8

GENOME_FA=Mmul8.fa

wget \
    'ftp://ftp.ensembl.org/pub/release-93/fasta/macaca_mulatta/dna/Macaca_mulatta.Mmul_8.0.1.dna_sm.toplevel.fa.gz' \
    -O ${GENOME_FA}.gz

gunzip ${GENOME_FA}.gz

FIRST_SCAFFOLD_LINE=`grep -n "^>.*scaffold" $GENOME_FA | head -n1 | cut -d":" -f1`
LAST_LINE=$(($FIRST_SCAFFOLD_LINE - 1 ))
head -n $LAST_LINE $GENOME_FA | \
    sed -e "s/^>\([^ ]*\) .*/>chr\\1/" > ${GENOME_FA/.fa/.chr.fa}

mv ${GENOME_FA/.fa/.chr.fa} $GENOME_FA

cd ../..

exit
