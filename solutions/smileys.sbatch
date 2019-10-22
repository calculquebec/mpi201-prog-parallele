#!/bin/bash
#SBATCH --ntasks=4               # number of MPI processes
#SBATCH --mem-per-cpu=1024M      # memory; default unit is megabytes
#SBATCH --time=0-00:05           # time (DD-HH:MM)
#SBATCH --job-name=smileys
#SBATCH --output=smileys.out

srun -n 4 ./smileys
