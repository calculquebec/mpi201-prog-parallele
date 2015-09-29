#include <mpi.h>
#include <math.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    int rank, size, n, i;
    double sum, pi;

    MPI_Init( &argc, &argv );
    MPI_Comm_size( MPI_COMM_WORLD, &size );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );

    do {
        if (rank == 0) {
            printf("Enter the number of intervals (0 quits) : ");
            fflush(stdout);
            scanf("%d", &n);
            if (n > 0) printf("-> %d iterations\n", n); else printf("done\n");
        }

        MPI_Bcast( ... );
        if (n == 0) break;

        sum = 0.0;
        for (i = n - 1 - rank; i >= 0; i -= size) {
            sum += (4.0 - 8.0 * (i % 2)) / (2.0 * i + 1);
        }

        MPI_Reduce( ... );

        if (rank == 0) {
            printf("PI is approximately %.16f, Error is %.16f\n",
                pi, fabs(pi - M_PI));
        }
    } while (1);

    MPI_Finalize();
    return 0;
}

