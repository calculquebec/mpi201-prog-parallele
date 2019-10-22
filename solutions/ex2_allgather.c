#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>
#define n 64

int main(int argc, char *argv[])
{

int i,iloc,ierr,proc,nproc, B[n];
int *A;

ierr = MPI_Init(&argc,&argv);

ierr = MPI_Comm_size(MPI_COMM_WORLD, &nproc);
ierr = MPI_Comm_rank(MPI_COMM_WORLD, &proc);

if ((proc==0) && (n%nproc != 0)) {
   printf("Number of processes incompatible with the size\n");
   ierr = MPI_Abort(MPI_COMM_WORLD,1);
}
A = (int *) malloc((n/nproc)*sizeof(int));
iloc=0;
for ( i=proc*n/nproc; i<(proc+1)*n/nproc ; i++) {
   A[iloc]=(i+1)*(i+1);
   iloc++;
}
ierr = MPI_Allgather(A,n/nproc,MPI_INT,
                   B,n/nproc,MPI_INT,MPI_COMM_WORLD);

printf("proc %i A = ", proc);
for (i = 0; i < n/nproc; i++)
   printf("%i ", A[i]);
printf("\n");

printf("proc %i B = ", proc);
for (i = 0; i < n; i++)
   printf("%i ", B[i]);
printf("\n");

free(A);
ierr = MPI_Finalize();

return 0;
}
