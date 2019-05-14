#include <math.h>
#include <mpi.h>
#include <stdio.h>

double integrale(int N, int proc, int nproc)
{
    int i;
    int debut = (proc) * N / nproc;
    int fin = (1+proc) * N / nproc;
    double dpint = 0.0, total;
    const double larg = M_PI / N;

    for (i = debut; i < fin; i++) {
        double sinCarre = sin(i*larg) * sin(i*larg);
        dpint += sinCarre * exp(-i*larg) * larg;
    }

    MPI_Allreduce(&dpint, &total, 1, MPI_DOUBLE,
                  MPI_SUM, MPI_COMM_WORLD);

    return total;
}

int main(int argc, char **argv)
{
    int proc = 0, nproc = 1;
    int N = 1;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &proc);
    MPI_Comm_size(MPI_COMM_WORLD, &nproc);

    while (N <= 1000000) {
        double dpint = integrale(N, proc, nproc);
        if (proc == 0) {
            printf("N = %d\n", N);
            printf("  dpint = %0.16g\n", dpint);
        }
        N *= 10;
    }

    if (proc == 0) {
        printf("Reference :\n");
        printf("   Int. = %0.16g\n", 2*(1-exp(-M_PI))/5);
    }

    MPI_Finalize();
    return 0;
}

