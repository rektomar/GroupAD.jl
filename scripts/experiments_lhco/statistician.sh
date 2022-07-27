#!/bin/bash
#SBATCH --partition=cpulong
#SBATCH --time=35:00:00
#SBATCH --nodes=1 --ntasks-per-node=2 --cpus-per-task=1
#SBATCH --mem=30G

MAX_SEED=$1
CONTAMINATION=$2

module load Python/3.8
module load Julia/1.7.3-linux-x86_64

julia --project ./statistician.jl ${MAX_SEED} events_anomalydetection_v2.h5 $CONTAMINATION