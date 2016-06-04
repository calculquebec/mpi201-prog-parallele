PROGRAM scatter

IMPLICIT NONE
INCLUDE 'mpif.h'

INTEGER ierr, myid, nproc, nsnd, i, root
INTEGER status(MPI_STATUS_SIZE)
REAL A(16), B(2)

    CALL MPI_Init(ierr)
    CALL MPI_Comm_size(MPI_COMM_WORLD, &
                      nproc, ierr)
    CALL MPI_Comm_rank(MPI_COMM_WORLD, &
                      myid, ierr)
    root = 0
    IF( myid == root ) THEN
        DO i = 1, 16
            a(i) = REAL(i)
        END DO
    END IF
    nsnd = 2
    CALL MPI_Scatter (a, nsnd, MPI_REAL, b, &
                      nsnd, MPI_REAL, root, &
                      MPI_COMM_WORLD, ierr)
    WRITE(*,*) myid, ': b(1)=', b(1), &
                      'b(2)=', b(2)

    CALL MPI_Finalize(ierr)

END PROGRAM scatter

