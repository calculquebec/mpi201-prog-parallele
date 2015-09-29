program bonjour
use mpi
integer p, np, ierr
call MPI_INIT(ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, np, ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, p, ierr)
print *, 'Ici le processus ',p, ' de ',np
call MPI_FINALIZE(ierr)
end
