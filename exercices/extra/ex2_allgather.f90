program allgather
use mpi
integer, parameter :: n=64
integer i,iloc,ierr,proc,nproc, B(n)
integer, allocatable :: A(:)
call MPI_Init(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, proc, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
if (proc==0 .and. mod(n,nproc) /= 0) then
   print *, 'Nombre de processus incompatible avec la taille'
   call MPI_Abort(MPI_COMM_WORLD,1,ierr)
endif
allocate (A(n/nproc))
iloc=1
do i=proc*n/nproc+1, (proc+1)*n/nproc
   a(iloc)=i**2
   iloc=iloc+1
enddo
call MPI_Allgather(...)
print *, 'proc ',proc,' A = ',A
print *, 'proc ',proc,' B = ',B
deallocate (A)
call MPI_Finalize(ierr)
end program allgather
