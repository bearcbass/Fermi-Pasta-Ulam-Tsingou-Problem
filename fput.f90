! File: fput.f90
! Author: Sebastian Osorio
! Purpose: Our main driver file

program fput
    use utility, only: fp
    use setup_module, only: setup_init, set_ics, nMasses, nSteps
    use leapfrog_module, only: evolve_system
    use output_module, only: WriteOutput
    implicit NONE
  
    real(fp), allocatable :: x(:,:)
  
    call setup_init()
  
    allocate(x(nMasses+2, nSteps))
  
    call set_ics(x)
  
    call evolve_system(x) 
  
    call WriteOutput(x)
  
    deallocate(x)
  
  end program fput
  