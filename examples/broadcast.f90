PROGRAM broadcast

IMPLICIT NONE
USE mpi

INTEGER ierr, myid, nproc, root
INTEGER status(MPI_STATUS_SIZE)
REAL a(2)

    CALL MPI_Init(ierr)
    CALL MPI_Comm_size(MPI_COMM_WORLD, &
                       nproc, ierr)
    CALL MPI_Comm_rank(MPI_COMM_WORLD, &
                       myid, ierr)
    root = 0

    IF( myid == root ) THEN
        a(1) = 2.0
        a(2) = 4.0
    END IF

    CALL MPI_BCAST(a, 2, MPI_REAL, root, &
                   MPI_COMM_WORLD, ierr)
    WRITE(*,*) myid, ': a(1)=', a(1), &
                       'a(2)=', a(2)
    CALL MPI_Finalize(ierr)

END PROGRAM broadcast

