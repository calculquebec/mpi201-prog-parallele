#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[]) {
    int rank, size, buffer1 = 123, buffer2 = 456;
    MPI_Status status;

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    if (size >= 2 && rank == 0) {
        MPI_Send( &buffer1, 1, MPI_INT, 1, 10, MPI_COMM_WORLD );
        MPI_Recv( &buffer2, 1, MPI_INT, 1, 20, MPI_COMM_WORLD, &status );
    }
    if (size >= 2 && rank == 1) {
        MPI_Recv( &buffer1, 1, MPI_INT, 0, 10, MPI_COMM_WORLD, &status );
        MPI_Send( &buffer2, 1, MPI_INT, 0, 20, MPI_COMM_WORLD );
    }

    printf("Rank %d: done\n", rank);
    MPI_Finalize();
    return 0;
}
