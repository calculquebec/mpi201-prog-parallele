#!/usr/bin/env python

from mpi4py import MPI  # MPI.Init() implicite
import sys


def main():
    """
    Programme principal
    """

    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    if size < 2:
        sys.exit(None)

    if rank == 0:
        matrix = [[i * 4 + j for j in range(4)] for i in range(4)]
        dest = 1
        tag = 54321

        comm.send(matrix, dest=dest, tag=tag)
        print(f'Process {rank} sent matrix=')

    if rank == 1:
        source = 0
        tag = MPI.ANY_TAG

        matrix = comm.recv(source=source, tag=tag)
        print(f'Process {rank} received matrix=')


    if rank < 2:
        for row in matrix:
            print(f'{row[0]:2} {row[1]:2} {row[2]:2} {row[3]:2}')

    MPI.Finalize()


if __name__ == '__main__':
    main()
