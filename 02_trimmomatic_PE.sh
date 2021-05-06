#!/bin/bash
#SBATCH --mem-per-cpu=32G
#SBATCH --time=0-24:00
#SBATCH --array=0-49
#SBATCH --partition=htc
#SBATCH --qos=maxjobs500
#SBATCH --job-name=trim
#SBATCH --account=scw1354
#SBATCH --mail-type=END
#SBATCH --mail-user=meesonnl@cardiff.ac.uk
#SBATCH --output=bin/OUT/trimmomatic/%A_%a-%J.o
#SBATCH --error=bin/ERR/trimmomatic/%A_%a-%J.e

myDir="/scratch/c.c1117174/cfc_trap"
sampleNames=(209_IP 209_T 210_IP 210_T 211_IP 211_T 212_IP 212_T 213_IP 213_T 214_IP 214_T 215_IP 215_T 227_IP 227_T 228_IP 228_T 229_IP 229_T 230_IP 230_T 231_IP 231_T 232_IP 249_IP 249_T 250_IP 250_T 251_IP 252_IP 252_T 253_IP 253_T 254_IP 254_T 255_IP 255_T 256_IP 256_T 261_IP 261_T 262_IP 262_T 263_IP 263_T 264_IP 264_T 265_IP 265_T)

mkdir -p ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}
mkdir -p ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic
 
module load trimmomatic/0.39
module load java/11.0

java -jar $TRIMMOMATIC PE -phred33 -trimlog ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic/${sampleNames[$SLURM_ARRAY_TASK_ID]}.log ${myDir}/input/${sampleNames[$SLURM_ARRAY_TASK_ID]}_1.fastq.gz ${myDir}/input/${sampleNames[$SLURM_ARRAY_TASK_ID]}_2.fastq.gz ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic/${sampleNames[$SLURM_ARRAY_TASK_ID]}.trimmed_1.fastq.gz ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic/${sampleNames[$SLURM_ARRAY_TASK_ID]}.unpaired_1.fastq.gz ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic/${sampleNames[$SLURM_ARRAY_TASK_ID]}.trimmed_2.fastq.gz ${myDir}/output/${sampleNames[$SLURM_ARRAY_TASK_ID]}/trimmomatic/${sampleNames[$SLURM_ARRAY_TASK_ID]}.unpaired_2.fastq.gz ILLUMINACLIP:${myDir}/resources/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

