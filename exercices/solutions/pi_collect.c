#include <mpi.h>
#include <math.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    int rank, size, n, i;
    double sum, pi, t1, t2;

    MPI_Init( &argc, &argv );
    MPI_Comm_size( MPI_COMM_WORLD, &size );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );

    do {
        if (rank == 0) {
            printf("Enter the number of intervals (0 quits) : ");
            fflush(stdout);
            scanf("%d", &n);
            if (n > 0) printf("-> %d iterations\n", n); else printf("done\n");
            t1 = MPI_Wtime();
        }

        MPI_Bcast( &n, 1, MPI_INT, 0, MPI_COMM_WORLD );
        if (n == 0) break;

        sum = 0.0;
        for (i = n - 1 - rank; i >= 0; i -= size) {
            sum += (4.0 - 8.0 * (i % 2)) / (2.0 * i + 1);
        }

        MPI_Reduce( &sum, &pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD );

        if (rank == 0) {
            t2 = MPI_Wtime();
            printf("PI is approximately %.16f, Error is %.16f\n",
                pi, fabs(pi - M_PI));
            printf("Time = %.16f sec\n", t2 - t1);
        }
    } while (1);

    MPI_Finalize();
    return 0;
}

