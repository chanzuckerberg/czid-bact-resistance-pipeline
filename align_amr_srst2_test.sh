#!/bin/sh
# Arguments: project_id, sample_id, output_dir, min_coverage, n_threads
# now have arguments jiust be the fiels srst2 needs
echo "at start" > /dev/stderr
FWD_FILE=$1
REV_FILE=$2
OUT_DIR=$3
echo "forward file " > /dev/stderr
echo $FWD_FILE > /dev/stderr
echo "reverse file " > /dev/stderr
echo $REV_FILE > /dev/stderr

# output="_output/"
# outputdir2="s3://idseq-database/test/AMR/"$SAMPLE_ID
# outputdir2="s3://msrinivasan-czbiohub-reflow-quickstart-cache/"$SAMPLE_ID
# mkdir $SAMPLE_ID$output
# echo "made dir " > /dev/stderr
# mkdir srst2_output
space=" "
# consider making a dir to run srst2 in?
# cd srst2_output
srst2 --input_pe $FWD_FILE$space$REV_FILE --forward R1_001 --reverse R2_001 --min_coverage 0 --threads 16 --output OUT_DIR  --log --gene_db ~/miniconda3/bin/srst2/data/ARGannot_r2.fasta
echo "ran srst2" > /dev/stderr

