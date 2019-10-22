PROGRAM scatter

USE mpi_f08
IMPLICIT NONE

INTEGER myid, nproc, nsnd, i, root
REAL A(16), B(2)

    CALL MPI_Init()
    CALL MPI_Comm_size(MPI_COMM_WORLD, &
                      nproc)
    CALL MPI_Comm_rank(MPI_COMM_WORLD, &
                      myid)
    root = 0
    IF( myid == root ) THEN
        DO i = 1, 16
            a(i) = REAL(i)
        END DO
    END IF
    nsnd = 2
    CALL MPI_Scatter (a, nsnd, MPI_REAL, b, &
                      nsnd, MPI_REAL, root, &
                      MPI_COMM_WORLD)
    WRITE(*,*) myid, ': b(1)=', b(1), &
                      'b(2)=', b(2)

    CALL MPI_Finalize()

END PROGRAM scatter

