#include <mpi.h>
#include <math.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    int rank, size, n, debut, fin, k;
    double somme, pi, t1, t2;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    do {
        if (rank == 0) {
            printf("Enter the number of intervals (0 quits) : ");
            fflush(stdout);
            scanf("%d", &n);
            if (n > 0) printf("-> %d iterations\n", n); else printf("done\n");
            t1 = MPI_Wtime();
        }

        MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
        if (n == 0) break;

        debut = rank * (long)n / size;
        fin = (rank + 1) * (long)n / size;

        somme = 0.0;
        for (k = fin - 1; k >= debut; --k) {
            somme += (4.0 - 8.0 * (k % 2)) / (2.0 * k + 1);
        }

        MPI_Reduce(&somme, &pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

        if (rank == 0) {
            t2 = MPI_Wtime();
            printf("PI is approximately %.16f, difference is %.16f\n",
                   pi, fabs(pi - M_PI));
            printf("Time = %.6f sec\n", t2 - t1);
        }
    } while (1);

    MPI_Finalize();
    return 0;
}

