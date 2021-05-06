#!/bin/bash --login
#SBATCH --mem-per-cpu=32G
#SBATCH --time=0-12:00
#SBATCH --array=0-49
#SBATCH --partition=htc
#SBATCH --qos=maxjobs500
#SBATCH --job-name=star
#SBATCH --account=scw1354
#SBATCH --mail-type=END
#SBATCH --mail-user=meesonnl@cardiff.ac.uk
#SBATCH --output=bin/OUT/star/%A_%a-%J.o
#SBATCH --error=bin/ERR/star/%A_%a-%J.e

set -eu

myDir="/scratch/c.c1117174/cfc_trap"
sampleNames=(209_IP 209_T 210_IP 210_T 211_IP 211_T 212_IP 212_T 213_IP 213_T 214_IP 214_T 215_IP 215_T 227_IP 227_T 228_IP 228_T 229_IP 229_T 230_IP 230_T 231_IP 231_T 232_IP 249_IP 249_T 250_IP 250_T 251_IP 252_IP 252_T 253_IP 253_T 254_IP 254_T 255_IP 255_T 256_IP 256_T 261_IP 261_T 262_IP 262_T 263_IP 263_T 264_IP 264_T 265_IP 265_T)
#GENOME_PATH="rattus_norvegicus_Rnor_6/"

mkdir -p ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/star
#mkdir -p ${myDir}/bin/OUT/star/
#mkdir -p ${myDir}/bin/ERR/star/

module load STAR

STAR --readFilesCommand zcat --outSAMunmapped Within KeepPairs --outMultimapperOrder Random --outSAMmultNmax 1 --runThreadN 1 --runMode alignReads --quantMode GeneCounts --outSAMtype BAM SortedByCoordinate --outFileNamePrefix ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/star/${sampleNames[$SLURM_ARRAY_TASK_ID]}.onemap. --genomeDir ${myDir}/resources/ --readFilesIn ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic/${sampleNames[$SLURM_ARRAY_TASK_ID]}.trimmed_1.fastq.gz ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic/${sampleNames[$SLURM_ARRAY_TASK_ID]}.trimmed_2.fastq.gz


