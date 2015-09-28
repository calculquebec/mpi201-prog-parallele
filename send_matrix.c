#include <stdio.h>
#include <mpi.h>

int main(int argc, char * argv[])
{
    int rank, size, count, dest, source, tag;
    int matrix[4][4], i, j;
    MPI_Status status;

    MPI_Init( ... );
    MPI_Comm_rank( ... );
    MPI_Comm_size( ... );
    if (size < 2) { MPI_Finalize(); return -1; }

    if (rank == 0) {
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 4; j++) {
                matrix[i][j] = i * 4 + j;
            }
        }
        count = ...;
        dest = ...;
        tag = ...;

        MPI_Send( ... );
        printf("Process %d sent matrix=\n", rank);
    }

    if (rank == 1) {
        count = ...;
        source = ...;
        tag = ...;

        MPI_Recv( ... );
        printf("Process %d received matrix=\n", rank);
    }

    if (rank < 2) {
        for (i = 0; i < 4; i++) {
            printf("%2d %2d %2d %2d\n",
                matrix[i][0], matrix[i][1], matrix[i][2], matrix[i][3]);
        }
    }

    MPI_Finalize();
    return 0;
}

