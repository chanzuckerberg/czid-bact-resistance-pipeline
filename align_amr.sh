#!/bin/sh
# Arguments: project_id, sample_id, output_dir, min_coverage, n_threads
PROJECT_ID=$1
SAMPLE_ID=$2
OUTPUT_DIR=$3
MIN_COVERAGE=$4
N_THREADS=$5
echo $PROJECT_ID
echo $SAMPLE_ID
echo $OUTPUT_DIR
echo $MIN_COVERAGE
echo $N_THREADS
aws s3 cp --recursive s3://idseq-samples-prod/samples/$PROJECT_ID/$SAMPLE_ID/fastqs/ $OUTPUT_DIR
INPUT=""
space=" "
for file in $OUTPUT_DIR/*
do
	INPUT=$INPUT$file$space
done

echo "Input command to srst2: "
echo $INPUT
output="output"

srst2 --input_pe $INPUT --forward 001 --reverse 002 --min_coverage $MIN_COVERAGE --threads $N_THREADS --output $SAMPLE_ID$output --log --gene_db ~/miniconda3/bin/srst2/data/ARGannot_r2.fasta
