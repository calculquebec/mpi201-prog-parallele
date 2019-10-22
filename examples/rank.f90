PROGRAM hello

USE mpi_f08
IMPLICIT NONE

REAL  a,b

INTEGER rank, size

    CALL MPI_Init()
    CALL MPI_Comm_rank (MPI_COMM_WORLD, rank)
    CALL MPI_Comm_size (MPI_COMM_WORLD, size)

    IF (rank == 0) THEN
	a=SQRT(2.0)
	b=0.0
	WRITE(*,*) 'a,b=',a,b,'on proc',rank	
    ENDIF
    
    IF (rank == 1) THEN
	a=0.0
	b=SQRT(3.0)
	WRITE(*,*) 'a,b=',a,b,'on proc',rank	
    ENDIF

    CALL  MPI_Finalize()
END PROGRAM hello
