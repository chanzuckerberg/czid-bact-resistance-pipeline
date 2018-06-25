#!/bin/sh
# Arguments: project_id, sample_id, output_dir, min_coverage, n_threads
echo "All the following flags must be provided: --project_id, --sample_id, --output_dir,
--min_coverage, and --n_threads"

while [[ $# -gt 0 ]];
do
key="$1"

case $key in
	-p|--project_id)
	PROJECT_ID="$2"
	shift #past argument
	shift #past value
	;;
	-s|--sample_id)
	SAMPLE_ID="$2"
	shift
	shift
	;;
	-o|--output_dir)
	OUTPUT_DIR="$2"
	shift
	shift
	;;
	-m|--min_coverage)
	MIN_COVERAGE="$2"
	shift
	shift
	;;
	-n|--n_threads)
	N_THREADS="$2"
	shift
	shift
	;;
	*)
	shift # past argument
	;;
esac
done

echo PROJECT ID = $PROJECT_ID
echo SAMPLE ID = $SAMPLE_ID
echo OUTPUT DIR = $OUTPUT_DIR
echo MIN COVERAGE = $MIN_COVERAGE
echo N THREADS = $N_THREADS	

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
