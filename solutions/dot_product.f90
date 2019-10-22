PROGRAM dot_product

USE mpi_f08
IMPLICIT NONE

INTEGER, PARAMETER :: N = 8400
INTEGER(selected_int_kind(18)), ALLOCATABLE :: A(:), B(:), Aloc(:), Bloc(:)
INTEGER(selected_int_kind(18)) :: prod, prodloc
INTEGER :: size, rank, nloc, i

    CALL MPI_Init( )
    CALL MPI_Comm_size( MPI_COMM_WORLD, size )
    CALL MPI_Comm_rank( MPI_COMM_WORLD, rank )

    IF (MOD(N, size) > 0) THEN
        WRITE(*,*) 'N must be a multiple of size'
        CALL MPI_Abort( MPI_COMM_WORLD, 999 )
    ENDIF

    IF (rank == 0) THEN
        ALLOCATE(A(N), B(N))
        DO I = 1, N
            A(I) = I
            B(I) = N - I + 1
        ENDDO
    ENDIF

    nloc = N / size
    ALLOCATE(Aloc(nloc), Bloc(nloc))

    CALL MPI_Scatter( A, nloc, MPI_INTEGER8, Aloc, nloc, MPI_INTEGER8, 0, MPI_COMM_WORLD )
    CALL MPI_Scatter( B, nloc, MPI_INTEGER8, Bloc, nloc, MPI_INTEGER8, 0, MPI_COMM_WORLD )

    prodloc = 0
    DO i = 1, nloc
        prodloc = prodloc + Aloc(i) * Bloc(i)
    ENDDO

    CALL MPI_Reduce( prodloc, prod, 1, MPI_INTEGER8, MPI_SUM, 0, MPI_COMM_WORLD )

    IF (rank == 0) THEN
        WRITE(*,*) 'Inner product   = ', prod
        WRITE(*,*) 'Reference value = ', INT8(N) * (N + 1) * (N + 2) / 6
    ENDIF

    CALL MPI_Finalize( )

END PROGRAM dot_product

