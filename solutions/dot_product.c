#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[])
{
    const int n = 8400;
    long int *a,    *b,    prod;    // Global
    long int *aloc, *bloc, prodloc; // Local
    int rank, size, i, nloc;

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    if (n % size > 0) {
        if (rank == 0) fprintf(stderr, "N must be a multiple of size\n");
        MPI_Abort( MPI_COMM_WORLD, 999 );
    }

    if (rank == 0) {
        a = (long int*)malloc(n * sizeof(long int));
        b = (long int*)malloc(n * sizeof(long int));

        for (i = 0; i < n; i++) {
            a[i] = i + 1;
            b[i] = n - i;
        }
    }

    nloc = n / size;
    aloc = (long int*)malloc(nloc * sizeof(long int));
    bloc = (long int*)malloc(nloc * sizeof(long int));

    MPI_Scatter( a, nloc, MPI_LONG, aloc, nloc, MPI_LONG, 0, MPI_COMM_WORLD );
    MPI_Scatter( b, nloc, MPI_LONG, bloc, nloc, MPI_LONG, 0, MPI_COMM_WORLD );

    prodloc = 0;
    for (i = 0; i < nloc; i++) {
        prodloc += aloc[i] * bloc[i];
    }

    MPI_Reduce( &prodloc, &prod, 1, MPI_LONG, MPI_SUM, 0, MPI_COMM_WORLD );

    if (rank == 0) {
        printf( "Inner product   = %lld\n", prod );
        printf( "Reference value = %lld\n", (long int)n * (n + 1) * (n + 2) / 6 );

        free(a);
        free(b);
    }

    free(aloc);
    free(bloc);

    MPI_Finalize();
    return 0;
}

