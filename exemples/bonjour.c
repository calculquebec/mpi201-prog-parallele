#include <stdio.h>
#include <mpi.h>

int main(int argc,char *argv[]) {
  int p, np;
  MPI_Init(&argc,&argv);

  MPI_Comm_rank(MPI_COMM_WORLD, &p);
  MPI_Comm_size(MPI_COMM_WORLD, &np);
  printf( "Ici le processus %d de %d\n", p, np );

  MPI_Finalize();
  return 0;
}
