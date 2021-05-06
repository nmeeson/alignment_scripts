#!/bin/bash --login
#SBATCH --mem-per-cpu=2G
#SBATCH --time=0-6:00
#SBATCH --array=0-49
#SBATCH --partition=htc
#SBATCH --qos=maxjobs500
#SBATCH --job-name=bamtools
#SBATCH --account=scw1354
#SBATCH --mail-type=END
#SBATCH --mail-user=meesonnl@cardiff.ac.uk
#SBATCH --output=bin/OUT/bamtools/%A_%a.o
#SBATCH --error=bin/ERR/bamtools/%A_%a.e

set -eu

myDir="/scratch/c.c1117174/cfc_trap"
sampleNames=(209_IP 209_T 210_IP 210_T 211_IP 211_T 212_IP 212_T 213_IP 213_T 214_IP 214_T 215_IP 215_T 227_IP 227_T 228_IP 228_T 229_IP 229_T 230_IP 230_T 231_IP 231_T 232_IP 249_IP 249_T 250_IP 250_T 251_IP 252_IP 252_T 253_IP 253_T 254_IP 254_T 255_IP 255_T 256_IP 256_T 261_IP 261_T 262_IP 262_T 263_IP 263_T 264_IP 264_T 265_IP 265_T)

mkdir -p ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/bamtools

module load bamtools/170119

bamtools stats -in ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/markduplicates/${sampleNames[$SLURM_ARRAY_TASK_ID]}.markdup.bam > ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/bamtools/${sampleNames[$SLURM_ARRAY_TASK_ID]}.markdup.dupstats.txt

#bamtools stats -in ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/hisat2/${sampleNames[$SLURM_ARRAY_TASK_ID]}.bam > ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/bamtools/${sampleNames[$SLURM_ARRAY_TASK_ID]}.dupstats.txt

#bamtools stats -in ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/hisat2/${sampleNames[$SLURM_ARRAY_TASK_ID]}.fixed.bam > ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/bamtools/${sampleNames[$SLURM_ARRAY_TASK_ID]}.fixed.dupstats.txt
