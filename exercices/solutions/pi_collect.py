#!/usr/bin/env python

from mpi4py import MPI  # MPI.Init() implicite
import math
import sys


def main():
    """
    Programme principal
    """

    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()
    n = None

    while True:
        if rank == 0:
            n = int(input('Enter the number of intervals (0 quits): '))
            print(f'-> {n} iterations' if n > 0 else 'done')
            t1 = MPI.Wtime()

        n = comm.bcast(n, 0)
        if n == 0:
            break

        debut = rank * n // size
        fin = (rank + 1) * n // size

        somme = 0.0;
        for k in range(fin - 1, debut - 1, -1):
            somme += (4.0 - 8.0 * (k % 2)) / (2.0 * k + 1)

        pi = comm.reduce(somme, MPI.SUM, 0)

        if rank == 0:
            t2 = MPI.Wtime()
            print(f'PI is approximately {pi:.16f},',
                  f'difference is {abs(pi - math.pi):.16f}')
            print(f'Time = {t2 - t1:.6f} sec')

    MPI.Finalize()


if __name__ == '__main__':
    main()
