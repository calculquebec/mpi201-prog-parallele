#include <stdio.h>
#include <mpi.h>
#define NMAX 10
#define max(i,j) ( i > j ? i : j )
#define min(i,j) ( i > j ? j : i )

int main(int argc, char *argv[])
{

int i,ierr,proc,nproc, A[NMAX];
int n;

ierr = MPI_Init(&argc,&argv);

ierr = MPI_Comm_size(MPI_COMM_WORLD, &nproc);
ierr = MPI_Comm_rank(MPI_COMM_WORLD, &proc);
if (proc==0) {
   printf("Entrer la valeur de n, de 1 à %i\n",NMAX);
   scanf("%i",&n);
   n=min(NMAX,max(1,n));
   for (i = 0; i < n; i++)
      A[i]=(i+1)*(i+1);
}
ierr = ...
ierr = ...

printf("proc %i A = ", proc);
for (i = 0; i < n; i++)
   printf("%i ", A[i]);
printf("\n");

ierr = MPI_Finalize();

return 0;
}
