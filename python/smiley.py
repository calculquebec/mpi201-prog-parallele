from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

print( "%3d/%-3d   :-D\n"%rank, size )

