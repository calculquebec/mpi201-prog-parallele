import sys
import numpy as np
from mpi4py import MPI

n = 8400

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if n % size > 0:
    if rank == 0:
        sys.stderr.write("N must be a multiple of size\n")
    comm.Abort(999)

if rank == 0:
    a = np.arange(1, n+1)
    b = n + 1 - a
else:
    a = None
    b = None

nloc = n // size
aloc = np.empty(nloc, int)
bloc = np.empty(nloc, int)

comm.Scatter(a, aloc, root=0)
comm.Scatter(b, bloc, root=0)

prodloc = np.dot(aloc, bloc)
prod = comm.reduce(prodloc, op=MPI.SUM, root=0)

if rank == 0:
    print("Inner product   = %d"%prod)
    print("Reference value = %d"%(n * (n + 1) * (n + 2) // 6))
