PROGRAM matrix
use mpi
IMPLICIT NONE

INTEGER :: rank, count, dest, source, tag
INTEGER :: matrix44(4,4), A(4,4), i
INTEGER :: error, status(MPI_STATUS_SIZE)

    CALL MPI_Init( error )
    CALL MPI_Comm_rank( MPI_COMM_WORLD, rank, error )

    IF (rank == 0) THEN
        A(:,:) = RESHAPE((/(I,I=1,16)/), SHAPE(A) )
        matrix44(:,:) = A(:,:)
        count = 16
        dest = 1
        tag = 54321

        CALL MPI_Send( matrix44, count, MPI_INTEGER, dest, tag, &
                       MPI_COMM_WORLD, error )
        WRITE(*,*) 'Process',rank,'sent matrix=', matrix44

    ELSE IF (rank == 1) THEN
        count = 16
        source = 0
        tag = MPI_ANY_TAG

        CALL MPI_Recv( matrix44, count, MPI_INTEGER, source, tag, &
                       MPI_COMM_WORLD, status, error )
        WRITE(*,*) 'Process', rank, 'received matrix=', matrix44
    END IF

    CALL MPI_Finalize( error )

END PROGRAM matrix

