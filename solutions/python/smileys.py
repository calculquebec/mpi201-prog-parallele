from mpi4py import MPI

smileys = [ ":-|", ":-)", ":-D", ":-P" ]

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank < 4:
    print("%3d/%-3d   %s"%(rank, size, smileys[rank]))
