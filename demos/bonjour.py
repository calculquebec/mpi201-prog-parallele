#!/usr/bin/env python

from mpi4py import MPI  # MPI.Init() implicite

def main():
    """
    Programme principal
    """

    p = MPI.COMM_WORLD.Get_rank()
    np = MPI.COMM_WORLD.Get_size()
    print(f'Ici le processus {p} de {np}')

    MPI.Finalize()

if __name__ == '__main__':
    main()
