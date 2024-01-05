! File: leapfrog_module.f90
! Author: Sebastian Osorio
! Purpose: Leapfrog solver that takes input and outputs
! the proper value. 

module leapfrog_module
    use setup_module
    use utility, only : fp, maxFileLen, maxStrLen, pi
    use setup_module, only: nMasses, nSteps, K, alpha, tFinal, dt, C
    implicit none
  
  contains
  
    subroutine evolve_system(x)
      implicit none
      
      real(fp), intent(inout) :: x(nMasses+2, nSteps)
      integer :: i, s
  
      print *, 'Running k: ', K
      print *, 'nSteps: ', nSteps
      print *, 'alpha: ', alpha
      print *, 'dt: ', dt
      print *, 'C: ', C
      print *, 'nMasses: ', nMasses
  
      do s = 2, nSteps-1
        do i = 1, nMasses+2
          x(i, s+1) = f(x,i,s)
        end do
      end do
  
    end subroutine evolve_system
  
    function f(x, i, s) result(nextPos)
      integer, intent(in) :: i, s
      real(fp), intent(in) :: x(nMasses + 2, nSteps-1)
      real(fp) :: nextPos
  
      if (i == 1 .or. i == nMasses+2) then 
        nextPos = 0.0_fp
      else
        nextPos = 2.0_fp * x(i,s) - x(i,s-1) + K*dt*dt &
                  * (x(i+1,s) - 2.0_fp*x(i,s) + x(i-1,s)) &
                  * (1.0_fp + alpha*(x(i+1,s) - x(i-1,s)))
      end if
    end function f
  
  end module leapfrog_module
  