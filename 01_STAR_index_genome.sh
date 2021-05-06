#!/bin/bash --login
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=0-08:00
#SBATCH --partition=htc
#SBATCH --job-name=STAR_generation
#SBATCH --account=scw1354
#SBATCH --mail-type=END
#SBATCH --mail-user=meesonnl@cardiff.ac.uk
#SBATCH --output=bin/OUT/index/index_%J.o
#SBATCH --error=bin/ERR/index/index_%J.e

myDir="/scratch/c.c1117174/cfc_trap"

GTF="Mus_musculus.GRCm39.103.gtf"
GENOME="Mus_musculus.GRCm39.dna_sm.toplevel.fa"

module load STAR

STAR --runThreadN 4 --runMode genomeGenerate --genomeDir ${myDir}/resources/ --genomeFastaFiles ${myDir}/resources/${GENOME} --sjdbGTFfile ${myDir}/resources/${GTF} --sjdbOverhang 149



