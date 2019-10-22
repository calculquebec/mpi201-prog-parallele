#include <stdio.h>
#include <mpi.h>
#include <math.h>

int main (int argc, char * argv[])
{
  int rank, size;

  MPI_Init( &argc, &argv );

  MPI_Comm_rank( MPI_COMM_WORLD, &rank );
  MPI_Comm_size( MPI_COMM_WORLD, &size );

  float a, b;
  if (rank == 0) {
    a = sqrt(2.0);
    b = 0.0;
  }
  if (rank == 1) {
    a = 0.0;
    b = sqrt(3.0);
  }
  printf("On proc %d: a, b = \t%f\t%f\n",
         rank, a, b);

  MPI_Finalize();

  return 0;
}
