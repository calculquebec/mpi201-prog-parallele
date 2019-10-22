program bcast
use mpi_f08
integer, parameter :: nmax=10
integer i,ierr,n,proc,nproc, A(nmax)

call MPI_Init()
call MPI_Comm_size(MPI_COMM_WORLD, nproc)
call MPI_Comm_size(MPI_COMM_WORLD, proc)
if (proc==0) then
   print '(A,I4)', 'Enter de value of n, between 1 and',nmax
   read *, n
   n=min(nmax,max(1,n))
   do i=1,n
      a(i)=i**2
   enddo
endif
call MPI_Bcast(n,1,MPI_INTEGER,0,MPI_COMM_WORLD)
call MPI_Bcast(A,n,MPI_INTEGER,0,MPI_COMM_WORLD)
print *, 'proc ',proc,' A(1:n) = ',A(1:n)
call MPI_Finalize()
end program bcast
