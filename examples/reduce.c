#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[]) {
    int rank, size, root = 0;
    float a[2], res[2];

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    a[0] = 2 * rank + 0;
    a[1] = 2 * rank + 1;

    MPI_Reduce( a, res, 2, MPI_FLOAT, MPI_SUM, root, MPI_COMM_WORLD );

    if (rank == root) {
        printf( "%d: res[0]=%f\tres[1]=%f\n", root, res[0], res[1] );
    }

    MPI_Finalize();
    return 0;
}

