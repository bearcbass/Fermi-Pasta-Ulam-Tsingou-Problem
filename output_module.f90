! File: output_module.f90
! Author: Sebastian Osorio
! Purpose: Takes the data from leapfrog module
! and outputs it into sol.dat.

module output_module
    use utility, only : fp, maxFileLen, maxStrLen, pi
    use setup_module, only: nMasses, nSteps, K, alpha, tFinal, dt, C, runName, outFile
    implicit none
  
  contains
  
    subroutine WriteOutput(x)
      implicit none

      real(fp), intent(in) :: x(nMasses+2, nSteps)
      integer :: i

      open(20, file="sol.dat", status="replace")
      do i = 1, nSteps
        write(20, *) x(:,i)
      end do
      close(20)

      open(20, file="parameters.dat", status="replace")

      write(20,*) "nMasses", nMasses
      write(20,*) "nSteps", nSteps
      write(20,*) "K", K
      write(20,*) "alpha", alpha
      write(20,*) "tFinal", tFinal
      write(20,*) "dt", dt
      write(20,*) "C", C
      
      close(20)

    end subroutine WriteOutput
  
  END MODULE output_module
  