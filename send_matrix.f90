PROGRAM matrix

USE mpi_f08
IMPLICIT NONE

INTEGER :: rank, count, dest, source, tag
INTEGER :: matrix44(4,4), A(4,4), i
TYPE(MPI_Status) :: status

    CALL MPI_Init( )
    CALL MPI_Comm_rank( ... )

    IF (rank == 0) THEN
        A(:,:) = RESHAPE((/(I,I=1,16)/), SHAPE(A) )
        matrix44(:,:) = A(:,:)
        count = ...
        dest = ...
        tag = ...

        CALL MPI_Send( ..., &
                       ... )
        WRITE(*,*) 'Process',rank,'sent matrix=', matrix44

    ELSE IF (rank == 1) THEN
        count = ...
        source = ...
        tag = ...

        CALL MPI_Recv( ..., &
                       ... )
        WRITE(*,*) 'Process', rank, 'received matrix=', matrix44
    END IF

    CALL MPI_Finalize( )

END PROGRAM matrix

