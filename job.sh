#!/bin/bash

#SBATCH -t 4880
#SBATCH --job-name pheval   ## name that will show up in the queue
#SBATCH -o ./jobs/slurm-%j.out   ## filename of the output; the %j is equal to jobID; default is slurm-[jobID].out
#SBATCH -e ./jobs/slurm-%j.err   ## filename of the output; the %j is equal to jobID; default is slurm-[jobID].out
#SBATCH --ntasks=1  ## number of tasks (analyses) to run
#SBATCH --cpus-per-task=32  ## the number of threads allocated to each task
#SBATCH --nodes=1
#SBATCH --mem=32G   # memory per CPU core
#

## Load modules
#  srun -t 2400 --mem 32g --pty bash
become spotbot
module load python/3.10.10
module load openjdk-17.0.5_8-gcc-11.2.0-gsv4jnu
python -m venv .venv
source .venv/bin/activate
pip install . -U
make pheval