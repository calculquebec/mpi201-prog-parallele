PROGRAM broadcast

USE mpi_f08
IMPLICIT NONE

INTEGER myid, nproc, root
TYPE(MPI_Status) :: status
REAL a(2)

    CALL MPI_Init()
    CALL MPI_Comm_size(MPI_COMM_WORLD, &
                       nproc)
    CALL MPI_Comm_rank(MPI_COMM_WORLD, &
                       myid)
    root = 0

    IF( myid == root ) THEN
        a(1) = 2.0
        a(2) = 4.0
    END IF

    CALL MPI_BCAST(a, 2, MPI_REAL, root, &
                   MPI_COMM_WORLD)
    WRITE(*,*) myid, ': a(1)=', a(1), &
                       'a(2)=', a(2)
    CALL MPI_Finalize()

END PROGRAM broadcast

