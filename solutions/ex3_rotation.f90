program rotation
use mpi_f08
implicit none
integer, parameter :: n=64
integer i,proc,nproc,prev,next,iter
type(MPI_Status) :: status
integer, allocatable :: A(:)
call MPI_Init()
call MPI_COMM_RANK(MPI_COMM_WORLD, proc)
call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc)
if (proc==0 .and. (mod(n,nproc) /= 0 .or. mod(n,2) /= 0)) then
   print *, 'Number of processes incompatible with the size'
   call MPI_Abort(MPI_COMM_WORLD,1)
endif
allocate (A(0:n/nproc))
do i=1,n/nproc
   a(i)=proc
enddo
print '(A,i2,A,64i5)', 'proc=',proc,' iter=0 A=',A(1:n/nproc)
do iter=1,n
  if (proc == 0) then
     prev=nproc-1
  else
     prev=proc-1
  endif
  if (proc==nproc-1) then
     next=0
  else
     next=proc+1
  endif
  if (mod(proc,2)==0) then
     call MPI_Send(A(n/nproc),1,MPI_INTEGER,next,iter,MPI_COMM_WORLD)
     call MPI_Recv(A(0),1,MPI_INTEGER,prev,iter,MPI_COMM_WORLD,status)
  else
     call MPI_Recv(A(0),1,MPI_INTEGER,prev,iter,MPI_COMM_WORLD,status)
     call MPI_Send(A(n/nproc),1,MPI_INTEGER,next,iter,MPI_COMM_WORLD)
  endif
  do i=n/nproc,1,-1
     A(i)=A(i-1)
  enddo
  print '(A,i2,A,i3,A,64i5)', 'proc=',proc,' iter=',iter,' A=',A(1:n/nproc)
enddo
deallocate (A)
call MPI_Finalize()
end program rotation
