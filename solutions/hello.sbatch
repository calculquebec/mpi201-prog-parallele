#!/bin/bash
#SBATCH --ntasks=8               # number of MPI processes
#SBATCH --mem-per-cpu=1024M      # memory; default unit is megabytes
#SBATCH --time=0-00:05           # time (DD-HH:MM)
#SBATCH --job-name=hello
#SBATCH --output=hello.out

srun -n 8 ./hello > hello.out
