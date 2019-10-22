program allgather
use mpi_f08
integer, parameter :: n=64
integer i,iloc,proc,nproc, B(n)
integer, allocatable :: A(:)
call MPI_Init()
call MPI_COMM_RANK(MPI_COMM_WORLD, proc)
call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc)
if (proc==0 .and. mod(n,nproc) /= 0) then
   print *, 'Number of processes incompatible with the size'
   call MPI_Abort(MPI_COMM_WORLD,1)
endif
allocate (A(n/nproc))
iloc=1
do i=proc*n/nproc+1, (proc+1)*n/nproc
   a(iloc)=i**2
   iloc=iloc+1
enddo
call MPI_Allgather(A,n/nproc,MPI_INTEGER, &
                   B,n/nproc,MPI_INTEGER,MPI_COMM_WORLD)
print *, 'proc ',proc,' A = ',A
print *, 'proc ',proc,' B = ',B
deallocate (A)
call MPI_Finalize()
end program allgather
