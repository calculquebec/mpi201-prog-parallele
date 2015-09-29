#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[]) {
    int rank, size, root = 0, i, sendcount;
    float a[16], b[2];

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    if (rank == root) {
        for (i = 0; i < 16; i++) {
            a[i] = i;
        }
    }

    sendcount = 2;
    MPI_Scatter ( a, sendcount, MPI_FLOAT,
                  b, sendcount, MPI_FLOAT,
                  root, MPI_COMM_WORLD );

    printf( "%d: b[0]=%f\tb[1]=%f\n",
            rank, b[0], b[1] );

    MPI_Finalize();
    return 0;
}

