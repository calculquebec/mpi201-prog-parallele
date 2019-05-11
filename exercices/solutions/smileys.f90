PROGRAM smileys
use mpi
IMPLICIT NONE

INTEGER ierr, rank, size

CALL MPI_Init(ierr)

CALL MPI_Comm_rank (MPI_COMM_WORLD, &
                    rank, ierr)

CALL MPI_Comm_size (MPI_COMM_WORLD, &
                    size, ierr)
IF (rank == 0) THEN
    WRITE(*,*) rank, '/', size, '  :-|'
ENDIF
IF (rank == 1) THEN
    WRITE(*,*) rank, '/', size, '  :-)'
ENDIF
IF (rank == 2) THEN
    WRITE(*,*) rank, '/', size, '  :-D'
ENDIF
IF (rank == 3) THEN
    WRITE(*,*) rank, '/', size, '  :-P'
ENDIF

CALL  MPI_Finalize(ierr)
END PROGRAM smileys
