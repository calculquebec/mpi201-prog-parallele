program hello
  use mpi_f08
  integer p, np
  call MPI_Init()
  call MPI_Comm_size(MPI_COMM_WORLD, np)
  call MPI_Comm_rank(MPI_COMM_WORLD, p)
  print *, 'Here is process ',p, ' of ',np
  call MPI_Finalize()
end
