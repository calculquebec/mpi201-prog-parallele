PROGRAM dot_product

IMPLICIT NONE
INCLUDE 'mpif.h'

INTEGER, PARAMETER :: N = 8400
INTEGER*8, ALLOCATABLE :: A(:), B(:), Aloc(:), Bloc(:)
INTEGER*8 :: prod, prodloc
INTEGER :: size, rank, ierr, nloc, i

    CALL MPI_Init( ierr )
    CALL MPI_Comm_size( MPI_COMM_WORLD, size, ierr )
    CALL MPI_Comm_rank( MPI_COMM_WORLD, rank, ierr )

    IF (MOD(N, size) > 0) THEN
        WRITE(*,*) 'N must be a multiple of size'
        CALL MPI_Abort( MPI_COMM_WORLD, 999, ierr )
    ENDIF

    IF (rank == 0) THEN
        ALLOCATE(A(N), B(N))
        DO I = 1, N
            A(I) = I
            B(I) = N - I + 1
        ENDDO
    ENDIF

    nloc = ...
    ALLOCATE(Aloc(nloc), Bloc(nloc))

    CALL MPI_Scatter( ... )
    CALL MPI_Scatter( ... )

    prodloc = 0
    DO i = 1, nloc
        prodloc = prodloc + Aloc(i) * Bloc(i)
    ENDDO

    CALL MPI_Reduce( ... )

    IF (rank == 0) THEN
        WRITE(*,*) 'Inner product   = ', prod
        WRITE(*,*) 'Reference value = ', INT8(N) * (N + 1) * (N + 2) / 6
    ENDIF

    CALL MPI_Finalize( ierr )

END PROGRAM dot_product

