#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>
#define n 64

int main(int argc, char *argv[])
{

int i,ierr,proc,nproc,prec,suiv,iter;
MPI_Status etat[MPI_STATUS_SIZE];
int *A;

ierr = MPI_Init(&argc,&argv);

ierr = MPI_Comm_size(MPI_COMM_WORLD, &nproc);
ierr = MPI_Comm_rank(MPI_COMM_WORLD, &proc);

if (proc==0 && (n%nproc /= 0 || n%2 != 0)) {
   printf("Nombre de processus incompatible avec la taille\n");
   ierr = MPI_Abort(MPI_COMM_WORLD,1);
}
A = (int *) malloc((n/proc+1) * sizeof(int));

for (i=1; i<= n/nproc; i++)
   a[i]=proc;

printf("proc %i iter=0 A = ", proc);
for (i = 1; i <= n/nproc; i++)
   printf("%i ", A[i]);
printf("\n");

for (i=1; i<=n; i++)
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
     ierr = MPI_Send(A[n/nproc],1,MPI_INTEGER,suiv,iter,MPI_COMM_WORLD);
     ierr = MPI_Recv(A[0],1,MPI_INTEGER,prec,iter,MPI_COMM_WORLD,etat);
  }
  else {
     ierr = MPI_Recv(A[0],1,MPI_INTEGER,prec,iter,MPI_COMM_WORLD,etat);
     ierr = MPI_Send(A[n/nproc],1,MPI_INTEGER,suiv,iter,MPI_COMM_WORLD);
  }
  for (i=n/nproc; i>=1; i--)
     A[i]=A[i-1];
  print '(A,i2,A,i3,A,64i5)', 'proc=',proc,' iter=',iter,' A=',A(1:n/nproc)
printf("proc %i iter=%i A = ", proc,iter);
for (i = 1; i <= n/nproc; i++)
   printf("%i ", A[i]);
printf("\n");
}
free(A);
ierr = MPI_Finalize();

return 0;
}
