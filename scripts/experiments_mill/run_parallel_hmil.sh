#!/bin/bash
# This runs parallel experiments over all datasets.
# USAGE EXAMPLE
# 	./run_parallel_mill.sh vae_basic 3 1 2 datasets_mill.txt 0.05
# Run from this folder only.
MODEL=$1 		# which model to run
NUM_SAMPLES=$2	# how many repetitions
MAX_SEED=$3		# how many folds over dataset
NUM_CONC=$4		# number of concurrent tasks in the array job
DATASET_FILE=$5	# file with dataset list

LOG_DIR="${HOME}/logs/${MODEL}"

if [ ! -d "$LOG_DIR" ]; then
	mkdir $LOG_DIR
fi

while read d; do
	# submit to slurm
    for na in 0 10 20 100
    do
        sbatch \
        --array=1-${NUM_SAMPLES}%${NUM_CONC} \
        --output="${LOG_DIR}/${d}-%A_%a.out" \
        ./${MODEL}.sh $MAX_SEED $d $na

        # for local testing    
        # ./${MODEL}_run.sh $MAX_SEED $d
    done
done < ${DATASET_FILE}