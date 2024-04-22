#include "mpi.h"

int main(int argc, char **argv)
{
    int ierr;
    ierr = MPI_Init(&argc, &argv);

    /* On insère le reste du programme ici. */

    ierr = MPI_Finalize();
}
