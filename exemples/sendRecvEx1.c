#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[]) {
    int rank, size, buffer = -1, tag = 10;
    MPI_Status status;

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    if (size >= 2 && rank == 0) {
        buffer = 33;
        MPI_Send( &buffer, 1, MPI_INT, 1, tag, MPI_COMM_WORLD );
    }
    if (size >= 2 && rank == 1) {
        MPI_Recv( &buffer, 1, MPI_INT, 0, tag, MPI_COMM_WORLD, &status );
        printf("Rank %d\tbuffer= %d\n", rank, buffer);
        if (buffer != 33) printf("fail\n");
    }

    MPI_Finalize();
    return 0;
}
