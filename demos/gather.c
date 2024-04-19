#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[]) {
    int rank, size, root = 0, i, sendcount;
    float a[16], b[2];

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    b[0] = rank;
    b[1] = rank;

    sendcount = 2;
    MPI_Gather( b, sendcount, MPI_FLOAT,
                a, sendcount, MPI_FLOAT,
                root, MPI_COMM_WORLD );

    if (rank == root) {
        for (i = 0; i < sendcount * size; i++) {
            printf( "%d: a[%d]=%f\n", rank, i, a[i]);
        }
    }

    MPI_Finalize();
    return 0;
}

