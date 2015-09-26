PROGRAM smiley

IMPLICIT NONE
INCLUDE 'mpif.h'

INTEGER ierr, rank, size

CALL MPI_Init(ierr)

CALL MPI_Comm_rank (MPI_COMM_WORLD, &
                    rank, ierr)

CALL MPI_Comm_size (MPI_COMM_WORLD, &
                    size, ierr)

WRITE(*,*) rank, '/', size, '  :-D'

CALL  MPI_Finalize(ierr)
END PROGRAM smiley
