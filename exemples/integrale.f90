subroutine integrale(dpint,N,proc,nproc)
use mpi
double precision :: dpint, dpintloc
integer N,proc,nproc,i,ierr
double precision, parameter:: pi=3.141592653589793d0
dpintloc = 0.0d0
do i=proc*N/nproc, (proc+1)*N/nproc - 1
   dpintloc = dpintloc + sin(i*(pi/N))**2 * exp(-i*(pi/N)) *(pi/N)
end do
call MPI_Reduce(dpintloc,dpint,1,MPI_DOUBLE_PRECISION, &
     MPI_SUM, 0, MPI_COMM_WORLD,ierr)
end subroutine integrale

program rectangle
use mpi
double precision dpint
integer proc,nproc,ierr,N

call MPI_INIT(ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, proc, ierr)

N=1
do while (N <= 1000000)
   call integrale(dpint,N,proc,nproc)
   if (proc==0) then
      print *, 'N = ',N
      print *, 'dpint = ',dpint
   endif
   N=N*10
enddo

call MPI_FINALIZE(ierr)
end program rectangle
