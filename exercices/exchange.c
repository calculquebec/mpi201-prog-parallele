#include <stdio.h>
#include <mpi.h>

int main(int argc, char* argv[])
{
    int rank, size;
    float A[2], B[2];
    MPI_Status status;

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );
    if (size < 2) { MPI_Finalize(); return -1; }

    if (rank == 0) {
        A[0] = 1.0f;
        A[1] = 2.0f;

        // Send and Receive
        MPI_...( ... );
        MPI_...( ... );
        printf("Process %d sent     A=[%f, %f]\n", rank, A[0], A[1]);
        printf("Process %d received B=[%f, %f]\n", rank, B[0], B[1]);
    }

    if (rank == 1) {
        B[0] = 3.0f;
        B[1] = 4.0f;

        // Send and Receive
        MPI_...( ... );
        MPI_...( ... );
        printf("Process %d sent     B=[%f, %f]\n", rank, B[0], B[1]);
        printf("Process %d received A=[%f, %f]\n", rank, A[0], A[1]);
    }

    MPI_Finalize();
    return 0;
}

