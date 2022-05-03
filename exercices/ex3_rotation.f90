program rotation
use mpi
implicit none
integer, parameter :: n=64
integer i,ierr,proc,nproc,prec,suiv,iter
integer etat(MPI_STATUS_SIZE)
integer, allocatable :: A(:)
call MPI_Init(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, proc, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
if (proc==0 .and. (mod(n,nproc) /= 0 .or. mod(n,2) /= 0)) then
   print *, 'Nombre de processus incompatible avec la taille'
   call MPI_Abort(MPI_COMM_WORLD,1,ierr)
endif
allocate (A(0:n/nproc))
do i=1,n/nproc
   a(i)=proc
enddo
print '(A,i2,A,64i5)', 'proc=',proc,' iter=0 A=',A(1:n/nproc)
do iter=1,n
  if (proc == 0) then
     prec=nproc-1
  else
     prec=proc-1
  endif
  if (proc==nproc-1) then
     suiv=0
  else
     suiv=proc+1
  endif
  if (mod(proc,2)==0) then
     call MPI_...
     call MPI_...
  else
     call MPI_...
     call MPI_...
  endif
  do i=n/nproc,1,-1
     A(i)=A(i-1)
  enddo
  print '(A,i2,A,i3,A,64i5)', 'proc=',proc,' iter=',iter,' A=',A(1:n/nproc)
enddo
deallocate (A)
call MPI_Finalize(ierr)
end program rotation
