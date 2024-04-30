#!/usr/bin/env python

from mpi4py import MPI  # MPI.Init() implicite
import sys


def main():
    """
    Programme principal
    """

    comm = ...
    rank = comm.
    size = comm.

    if size < 2:
        sys.exit(None)

    if rank == 0:
        matrix = [[i * 4 + j for j in range(4)] for i in range(4)]
        dest = ...
        tag = ...

        .send( ... )
        print(f'Process {rank} sent matrix=')

    if rank == 1:
        source = ...
        tag = ...

        .recv( ... )
        print(f'Process {rank} received matrix=')


    if rank < 2:
        for row in matrix:
            print(f'{row[0]:2} {row[1]:2} {row[2]:2} {row[3]:2}')

    MPI.Finalize()


if __name__ == '__main__':
    main()
