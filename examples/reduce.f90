PROGRAM reduce

IMPLICIT NONE
USE mpi

INTEGER ierr, myid, nproc, root
INTEGER status(MPI_STATUS_SIZE)
REAL A(2), res(2)

    CALL MPI_Init(ierr)
    CALL MPI_Comm_size(MPI_COMM_WORLD, nproc, ierr)
    CALL MPI_Comm_rank(MPI_COMM_WORLD, myid, ierr)

    root = 0
    a(1) = 2 * myid + 0
    a(2) = 2 * myid + 1

    CALL MPI_REDUCE(a, res, 2, MPI_REAL, MPI_SUM, root, &
                    MPI_COMM_WORLD, ierr)
    IF( myid == root ) THEN
        WRITE(*,*) myid, ': res(1)=', res(1), &
                           'res(2)=', res(2)
    END IF

    CALL MPI_Finalize(ierr)

END PROGRAM reduce

