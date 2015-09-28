IF( rank == 0 ) THEN

    CALL MPI_Send( buffer1, 1, MPI_INTEGER, 1, 10, &
                   MPI_COMM_WORLD, error )
    CALL MPI_Recv( buffer2, 1, MPI_INTEGER, 1, 20, &
                   MPI_COMM_WORLD, status, error )

ELSE IF( rank == 1 ) THEN

    CALL MPI_Recv( buffer1, 1, MPI_INTEGER, 0, 10, &
                   MPI_COMM_WORLD, status, error )
    CALL MPI_Send( buffer2, 1, MPI_INTEGER, 0, 20, &
                   MPI_COMM_WORLD, error )

END IF
