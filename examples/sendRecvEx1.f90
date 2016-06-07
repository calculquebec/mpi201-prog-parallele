PROGRAM sendRecvEx1
use mpi
IMPLICIT NONE

INTEGER :: rank, buffer, error, status( MPI_status_size )

    CALL MPI_init( error )
    CALL MPI_Comm_rank( MPI_COMM_WORLD, rank, error )

    IF( rank == 0 ) THEN
        buffer = 33
        CALL MPI_Send( buffer, 1, MPI_INTEGER, 1, 10, &
                       MPI_COMM_WORLD, error )
    END IF
    IF( rank == 1 ) THEN
        CALL MPI_Recv( buffer, 1, MPI_INTEGER, 0, 10, &
            MPI_COMM_WORLD, status, error )
        PRINT*, 'Rank ', rank, ' buffer=', buffer
        IF( buffer /= 33 ) Print*, 'fail'
    END IF

    CALL MPI_Finalize( error )
END PROGRAM sendRecvEx1
