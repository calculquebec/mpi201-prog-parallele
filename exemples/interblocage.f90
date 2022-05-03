program interblocage
use mpi
integer ierr,nproc,proc
integer A,B

call MPI_Init(ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc, ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, proc, ierr)

if (proc==0) A=7
if (proc==1) B=12
call echange(A,B,proc,nproc)
if (proc==0) print *, 'B = ',B
if (proc==1) print *, 'A = ',A

if (proc==0) A=7
if (proc==1) B=12
call subtampon(A,B,proc,nproc)
if (proc==0) print *, 'B = ',B
if (proc==1) print *, 'A = ',A

if (proc==0) A=7
if (proc==1) B=12
call sendrecv(A,B,proc,nproc)
if (proc==0) print *, 'B = ',B
if (proc==1) print *, 'A = ',A

if (proc==0) A=7
if (proc==1) B=12
call nonbloquant(A,B,proc,nproc)
if (proc==0) print *, 'B = ',B
if (proc==1) print *, 'A = ',A

call MPI_Finalize(ierr)
end program interblocage

subroutine erreur(A,B,proc,nproc)
use MPI
integer A,B,proc,nproc
integer ierror
integer STATUS(MPI_STATUS_SIZE)

If (proc == 0) then
     call MPI_Ssend(A, 1, MPI_INTEGER, 1, 1, MPI_COMM_WORLD, ierror)
     call MPI_Recv(B, 1, MPI_INTEGER, 1, 2, MPI_COMM_WORLD, status, ierror)
else if (proc == 1) then
     call MPI_Ssend(B, 1, MPI_INTEGER, 0, 2, MPI_COMM_WORLD, ierror)
     call MPI_Recv(A, 1, MPI_INTEGER, 0, 1, MPI_COMM_WORLD, status, ierror)
endif
end subroutine erreur

subroutine echange(A,B,proc,nproc)
use MPI
integer A,B,proc,nproc
integer ierror
integer STATUS(MPI_STATUS_SIZE)

If (proc == 0) then
     call MPI_Ssend(A, 1, MPI_INTEGER, 1, 1, MPI_COMM_WORLD, ierror)
     call MPI_Recv(B, 1, MPI_INTEGER, 1, 2, MPI_COMM_WORLD, status, ierror)
else if (proc == 1) then
     call MPI_Recv(A, 1, MPI_INTEGER, 0, 1, MPI_COMM_WORLD, status, ierror)
     call MPI_Ssend(B, 1, MPI_INTEGER, 0, 2, MPI_COMM_WORLD, ierror)
endif

end subroutine echange

subroutine subtampon(A,B,proc,nproc)
use MPI
integer A,B,proc,nproc
integer ierror
integer STATUS(MPI_STATUS_SIZE)
integer N, taille
integer, allocatable :: tampon(:)

call MPI_Pack_size(1, MPI_INTEGER, MPI_COMM_WORLD, N,ierror)
taille = N+MPI_BSEND_OVERHEAD
allocate (tampon(taille))
call MPI_Buffer_attach(tampon,taille,ierror)
If (proc == 0) then
     call MPI_Bsend(A, 1, MPI_INTEGER, 1, 1, MPI_COMM_WORLD, ierror)
     call MPI_Recv(B, 1, MPI_INTEGER, 1, 2, MPI_COMM_WORLD, status, ierror)
else if (proc == 1) then
     call MPI_Bsend(B, 1, MPI_INTEGER, 0, 2, MPI_COMM_WORLD, ierror)
     call MPI_Recv(A, 1, MPI_INTEGER, 0, 1, MPI_COMM_WORLD, status, ierror)
endif
call MPI_Buffer_detach(tampon,taille,ierror)
deallocate(tampon)

end subroutine subtampon


subroutine sendrecv(A,B,proc,nproc)
use MPI
integer A,B,proc,nproc
integer ierror
integer STATUS(MPI_STATUS_SIZE)

If (proc == 0) then
     call MPI_Sendrecv(A, 1, MPI_INTEGER, 1, 1,  &
                       B, 1, MPI_INTEGER, 1, 2,  &
                       MPI_COMM_WORLD, status, ierror)
else if (proc == 1) then
     call MPI_Sendrecv(B, 1, MPI_INTEGER, 0, 2,  &
                       A, 1, MPI_INTEGER, 0, 1,  &
                       MPI_COMM_WORLD, status, ierror)
endif
end subroutine sendrecv

subroutine nonbloquant(A,B,proc,nproc)
use MPI
integer A,B,proc,nproc
integer ierror,requete
integer STATUS(MPI_STATUS_SIZE)

If (proc == 0) then
     call MPI_Isend(A, 1, MPI_INTEGER, 1, 1, MPI_COMM_WORLD, requete, ierror)
     call MPI_Recv(B, 1, MPI_INTEGER, 1, 2, MPI_COMM_WORLD, status, ierror)
else if (proc == 1) then
     call MPI_Isend(B, 1, MPI_INTEGER, 0, 2, MPI_COMM_WORLD, requete, ierror)
     call MPI_Recv(A, 1, MPI_INTEGER, 0, 1, MPI_COMM_WORLD, status, ierror)
endif
call MPI_Wait(requete,status,ierror)
end subroutine nonbloquant
