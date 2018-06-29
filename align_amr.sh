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

echo PROJECT ID = $PROJECT_ID > /dev/stderr
echo SAMPLE ID = $SAMPLE_ID > /dev/stderr
echo OUTPUT DIR = $OUTPUT_DIR > /dev/stderr
echo MIN COVERAGE = $MIN_COVERAGE > /dev/stderr
echo N THREADS = $N_THREADS	> /dev/stderr

aws s3 cp --recursive s3://idseq-samples-prod/samples/$PROJECT_ID/$SAMPLE_ID/fastqs/ $OUTPUT_DIR
INPUT=""
space=" "
for file in $OUTPUT_DIR/*
do
	INPUT=$INPUT$file$space
	echo INPUT > /dev/stderr
done

echo "Input command to srst2: " > /dev/stderr
echo $INPUT
output="_output/"
#outputdir2="s3://idseq-database/test/AMR/"$SAMPLE_ID
outputdir2="s3://msrinivasan-czbiohub-reflow-quickstart-cache/"$SAMPLE_ID
mkdir $SAMPLE_ID$output
echo "made dir " > /dev/stderr
srst2 --input_pe $INPUT --forward 001 --reverse 002 --min_coverage $MIN_COVERAGE --threads $N_THREADS --output $SAMPLE_ID$output  --log --gene_db ~/miniconda3/bin/srst2/data/ARGannot_r2.fasta
echo "ran srst2" > /dev/stderr
aws s3 cp $SAMPLE_ID$output  s3://idseq-database/test/AMR/$SAMPLE_ID --recursive
rm -r $SAMPLE_ID$output
