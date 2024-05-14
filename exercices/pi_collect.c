#include <mpi.h>
#include <math.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    int rank, size, n, debut, fin, k;
    double somme, pi;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    do {
        if (rank == 0) {
            printf("Enter the number of intervals (0 quits) : ");
            fflush(stdout);
            scanf("%d", &n);
            if (n > 0) printf("-> %d iterations\n", n); else printf("done\n");
        }

        MPI_Bcast( ... );
        if (n == 0) break;

        debut = ... (long)n ...
        fin = ... (long)n ...

        somme = 0.0;
        for (k = fin - 1; k >= debut; --k) {
            somme += (4.0 - 8.0 * (k % 2)) / (2.0 * k + 1);
        }

        MPI_Reduce( ... );

        if (rank == 0) {
            printf("PI is approximately %.16f, difference is %.16f\n",
                   pi, fabs(pi - M_PI));
        }
    } while (1);

    MPI_Finalize();
    return 0;
}

