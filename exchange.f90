PROGRAM exchange

USE mpi_f08
IMPLICIT NONE

INTEGER :: rank
REAL :: A(2), B(2)
TYPE(MPI_Status) :: status

    CALL MPI_Init( )
    CALL MPI_Comm_rank( MPI_COMM_WORLD, rank )

    IF (rank == 0) THEN
        A=(/1.0,2.0/)

        CALL ...
        CALL ...
        WRITE(*,*) 'Process', rank, 'sent     A=', A
        WRITE(*,*) 'Process', rank, 'received B=', B

    ELSE IF (rank == 1) THEN
        B=(/3.0,4.0/)

        CALL ...
        CALL ...
        WRITE(*,*) 'Process', rank, 'sent     B=', B
        WRITE(*,*) 'Process', rank, 'received A=', A
    END IF

    CALL MPI_Finalize( )

END PROGRAM exchange

