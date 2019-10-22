PROGRAM smileys

USE mpi_f08
IMPLICIT NONE

INTEGER rank, size

CALL MPI_Init()

CALL MPI_Comm_rank (MPI_COMM_WORLD, &
                    rank)

CALL MPI_Comm_size (MPI_COMM_WORLD, &
                    size)
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

CALL  MPI_Finalize()
END PROGRAM smileys
