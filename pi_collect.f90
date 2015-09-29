PROGRAM PI_collect

IMPLICIT NONE
INCLUDE 'mpif.h'

DOUBLE PRECISION PI25, sum, pi
INTEGER rank, size, n, i, ierr

PARAMETER (PI25 = 3.141592653589793d0)

    CALL MPI_Init( ierr )
    CALL MPI_Comm_rank( MPI_COMM_WORLD, rank, ierr )
    CALL MPI_Comm_size( MPI_COMM_WORLD, size, ierr )

    DO
        IF( rank == 0 ) THEN
            WRITE(*,*) 'Enter the number of intervals (0 quits) : '
            READ(*,*) n
        ENDIF

        CALL MPI_Bcast( ... )
        IF ( n <= 0 ) EXIT

        sum = 0.0d0
        DO i = n - 1 - rank, 0, -size
            sum = sum + (4.0d0 - 8 * MOD(i, 2)) / (2 * DBLE(i) + 1)
        ENDDO

        CALL MPI_Reduce( ... )

        IF (rank == 0) THEN
            WRITE(*, "(' Pi is approximately: ', F19.16, ' Error is: ', F19.16)") pi, ABS(pi - PI25)
        ENDIF
    ENDDO

    CALL MPI_Finalize(ierr)

END PROGRAM pi_collect

