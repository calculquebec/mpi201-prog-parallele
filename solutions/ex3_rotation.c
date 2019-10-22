#include <stdio.h>
#include "mpi.h"
#include <stdlib.h>
#define n 64

int main(int argc, char *argv[])
{

int i,ierr,proc,nproc,prev,next,iter;
MPI_Status status;
int *A;

ierr = MPI_Init(&argc,&argv);

ierr = MPI_Comm_size(MPI_COMM_WORLD, &nproc);
ierr = MPI_Comm_rank(MPI_COMM_WORLD, &proc);

if (proc==0 && (n%nproc != 0 || n%2 != 0)) {
   printf("Number of processes incompatible with the size\n");
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
     prev=nproc-1;
  else
     prev=proc-1;
  if (proc==nproc-1)
     next=0;
  else
     next=proc+1;

  if (proc%2 == 0) {
     ierr = MPI_Send(&(A[n/nproc]),1,MPI_INT,next,iter,MPI_COMM_WORLD);
     ierr = MPI_Recv(A,1,MPI_INT,prev,iter,MPI_COMM_WORLD,&status);
  }
  else {
     ierr = MPI_Recv(A,1,MPI_INT,prev,iter,MPI_COMM_WORLD,&status);
     ierr = MPI_Send(&(A[n/nproc]),1,MPI_INT,next,iter,MPI_COMM_WORLD);
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
