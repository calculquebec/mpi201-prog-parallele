#!/bin/bash
#SBATCH --ntasks=...             # number of MPI processes
#SBATCH --mem-per-cpu=1024M      # memory; default unit is megabytes
#SBATCH --time=0-00:05           # time (DD-HH:MM)
#SBATCH -N smiley

srun -n # ./smiley > smiley.out
