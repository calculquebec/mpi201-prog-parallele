#include <stdio.h>
#include "mpi.h"
#include <stdlib.h>
#define n 64

int main(int argc, char *argv[])
{

int i,ierr,proc,nproc,prec,suiv,iter;
MPI_Status etat;
int *A;

ierr = MPI_Init(&argc,&argv);

ierr = MPI_Comm_size(MPI_COMM_WORLD, &nproc);
ierr = MPI_Comm_rank(MPI_COMM_WORLD, &proc);

if (proc==0 && (n%nproc != 0 || n%2 != 0)) {
   printf("Nombre de processus incompatible avec la taille\n");
   ierr = MPI_Abort(MPI_COMM_WORLD,1);
}
A = (int *) malloc((n/nproc+1) * sizeof(int));

for (i=1; i<= n/nproc; i++)
   A[i]=proc;

printf("proc %i iter=0 A = ", proc);
for (i = 1; i <= n/nproc; i++)
   printf("%i ", A[i]);
printf("\n");

for (iter=1; iter<=n; iter++)
{
  if (proc == 0)
     prec=nproc-1;
  else
     prec=proc-1;
  if (proc==nproc-1)
     suiv=0;
  else
     suiv=proc+1;

  if (proc%2 == 0) {
     ierr = MPI_...;
     ierr = MPI_...;
  }
  else {
     ierr = MPI_...;
     ierr = MPI_...;
  }
  for (i=n/nproc; i>=1; i--)
     A[i]=A[i-1];
  printf("proc %i iter=%i A = ", proc,iter);
  for (i = 1; i <= n/nproc; i++)
     printf("%i ", A[i]);
  printf("\n");
}
free(A);
ierr = MPI_Finalize();

return 0;
}
