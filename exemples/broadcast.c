#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[]) {
    int rank, size, root = 0;
    float a[2];

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    if (rank == root) {
        a[0] = 2.0f;
        a[1] = 4.0f;
    }

    MPI_Bcast( a, 2, MPI_FLOAT, root,
               MPI_COMM_WORLD );
    printf( "%d: a[0]=%f\ta[1]=%f\n",
            rank, a[0], a[1] );

    MPI_Finalize();
    return 0;
}

