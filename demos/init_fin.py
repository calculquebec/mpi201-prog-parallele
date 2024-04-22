#!/usr/bin/env python

from mpi4py import MPI  # MPI.Init() implicite

def main():
    """
    Programme principal
    """

    MPI.Finalize()

if __name__ == '__main__':
    main()
