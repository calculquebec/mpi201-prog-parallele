#include <stdio.h>
#include <mpi.h>

int main (int argc, char * argv[])
{
  int rank, size;

  MPI_Init( &argc, &argv );

  MPI_Comm_rank( MPI_COMM_WORLD, &rank );
  MPI_Comm_size( MPI_COMM_WORLD, &size );

  if (rank == 0) printf( "%3d/%-3d   :-|\n", rank, size );
  if (rank == 1) printf( "%3d/%-3d   :-)\n", rank, size );
  if (rank == 2) printf( "%3d/%-3d   :-D\n", rank, size );
  if (rank == 3) printf( "%3d/%-3d   :-P\n", rank, size );

  MPI_Finalize();

  return 0;
}
