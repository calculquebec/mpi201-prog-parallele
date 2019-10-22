PROGRAM gather

USE mpi_f08
IMPLICIT NONE

INTEGER myid, nproc, nsnd, i, root
INTEGER status(MPI_STATUS_SIZE)
REAL A(16), B(2)

    CALL MPI_Init()
    CALL MPI_Comm_size(MPI_COMM_WORLD, nproc)
    CALL MPI_Comm_rank(MPI_COMM_WORLD, myid)

    root = 0
    b(1) = REAL( myid )
    b(2) = REAL( myid )

    nsnd = 2
    CALL MPI_Gather(b, nsnd, MPI_REAL, &
                    a, nsnd, MPI_REAL, root, &
                    MPI_COMM_WORLD)

    IF( myid == root ) THEN
        DO i = 1, (nsnd*nproc)
            WRITE(*,*) myid, ': a(i)=', a(i)
        END DO
    END IF

    CALL MPI_Finalize()

END PROGRAM gather

