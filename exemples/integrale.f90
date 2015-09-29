subroutine integrale(dpint,N)
double precision dpint
integer N,i
double precision, parameter:: & pi=3.141592653589793d0
dpint = 0.0d0
do i=0,N-1
   dpint = dpint + sin(i*(pi/N))**2 * exp(-i*(pi/N)) *(pi/N)
end do
end subroutine integrale

program rectangle
double precision dpint
integer N

N=1
do while (N <= 1000000)
   call integrale(dpint,N)
   print *, 'N = ',N
   print *, 'dpint = ',dpint
   N=N*10
enddo
end program rectangle
