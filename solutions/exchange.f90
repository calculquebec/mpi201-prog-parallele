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

        CALL MPI_Send( A, 2, MPI_REAL, 1, 10, MPI_COMM_WORLD )
        CALL MPI_Recv( B, 2, MPI_REAL, 1, 20, MPI_COMM_WORLD, status )
        WRITE(*,*) 'Process', rank, 'sent     A=', A
        WRITE(*,*) 'Process', rank, 'received B=', B

    ELSE IF (rank == 1) THEN
        B=(/3.0,4.0/)

        CALL MPI_Recv( A, 2, MPI_REAL, 0, 10, MPI_COMM_WORLD, status )
        CALL MPI_Send( B, 2, MPI_REAL, 0, 20, MPI_COMM_WORLD  )
        WRITE(*,*) 'Process', rank, 'sent     B=', B
        WRITE(*,*) 'Process', rank, 'received A=', A
    END IF

    CALL MPI_Finalize( )

END PROGRAM exchange

