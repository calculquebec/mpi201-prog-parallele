PROGRAM reduce

USE mpi_f08
IMPLICIT NONE

INTEGER myid, nproc, root
REAL A(2), res(2)

    CALL MPI_Init()
    CALL MPI_Comm_size(MPI_COMM_WORLD, nproc)
    CALL MPI_Comm_rank(MPI_COMM_WORLD, myid)

    root = 0
    a(1) = 2 * myid + 0
    a(2) = 2 * myid + 1

    CALL MPI_REDUCE(a, res, 2, MPI_REAL, MPI_SUM, root, &
                    MPI_COMM_WORLD)
    IF( myid == root ) THEN
        WRITE(*,*) myid, ': res(1)=', res(1), &
                           'res(2)=', res(2)
    END IF

    CALL MPI_Finalize()

END PROGRAM reduce

