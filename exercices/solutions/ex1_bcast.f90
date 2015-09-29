program bcast
use mpi
integer, parameter :: nmax=10
integer i,ierr,proc,nproc, A(nmax)

call MPI_Init(ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, proc, ierr)
if (proc==0) then
   print '(A,I4)', 'Entrer la valeur de n, de 1 à',nmax
   read *, n
   n=min(nmax,max(1,n))
   do i=1,n
      a(i)=i**2
   enddo
endif
call MPI_Bcast(n,1,MPI_INTEGER,0,MPI_COMM_WORLD,ierr)
call MPI_Bcast(A,n,MPI_INTEGER,0,MPI_COMM_WORLD,ierr)
print *, 'proc ',proc,' A(1:n) = ',A(1:n)
call MPI_Finalize(ierr)
end program bcast
