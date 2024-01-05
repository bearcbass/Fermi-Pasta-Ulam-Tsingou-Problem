! File: Setup_module.f90
! Author: Ian May, Sebastian Osorio
! Purpose: Sets up the parameters for the problem

module setup_module

    use utility, only : fp, maxFileLen, maxStrLen, pi
    
    implicit none
    private
  
    integer, public :: nMasses, nSteps
    real (fp), public :: K, alpha, tFinal, dt, C
    character(len=maxStrLen), public :: runName, outFile
    character(len=maxStrLen) :: inFile
  
    public :: setup_init
    public :: set_ics
  
  contains
  
    subroutine setup_init()
      implicit none
  
      ! Get name of input file
      call get_command_argument(1,inFile)
      print *, "Reading from ",inFile
      
      ! Fill in default values
      nMasses = 1
      tFinal = 10*pi
      K = 1.0_fp
      alpha = 0.0_fp
      C = 1.0
      
      ! Read problem settings from the input file
      nMasses = read_initFileInt('num_masses')
      alpha = read_initFileReal('alpha')
      C = read_initFileReal('C')
  
      !!! ====================== Calculate K, nSteps, and dt here ===============================
      K = 4.0_fp * (nMasses + 1)**2.0_fp
      ! For Part C.
      alpha = nMasses/10.0_fp

      if (abs(alpha) > 0.0_fp) then
        nSteps = ceiling((real(tFinal) * real(sqrt(K))) / C)
      else
        nSteps = ceiling(real(tFinal) * real(sqrt(K)))
      end if
      dt = tFinal/nSteps
      

      ! Just manually setting stuff for fun. (Will be removed later)
      !nSteps = 1250.0
      !nSteps = 5000.0
      !dt = 0.00249333
      !alpha = 1.0_fp

      ! This is for debugging
      print *, 'nSteps: ', nSteps
      
      ! Set the name of the run and echo it out
      call read_initFileChar('run_name',runName)
      print *, 'Running problem: ', runName
      
      ! Set the output file, note that // does string concatenation
      outFile = 'data/' // trim(runName) // '.dat'
    end subroutine setup_init
  
    !!! ============================= Add set_ics subroutine here ===============================
    subroutine set_ics(x)
      implicit none
      real(fp), intent(inout):: x(nMasses + 2, nSteps)
      real(fp), dimension(nMasses + 2) :: v
      integer :: i
      !integer :: j

      ! might need to change this to x(:,:)
      x(:,1) = 0.0_fp
    
      ! Set velocity array
      do i = 1, nMasses+2
        if (i == 1 .or. i == nMasses+2) then
          v(i) = 0
        else
          v(i) = sin(real(pi*(i-1))/real(nMasses+1))
        end if
      end do

      !Now using velocity and x0 we can get x1
      do i = 1, nMasses+2
        if (i == 1 .or. i == nMasses+2) then
          x(i,2) = 0.0_fp
        else
          x(i,2) = x(i,1) + dt * v(i)
        end if
      end do

    end subroutine set_ics
    
  
    ! function: read_initFileInt
    ! purpose: Pull one integer value from an input file
    ! inputs: varName -- String that names the variable, this must be first entry on a line
    ! outputs: varValue -- Integer value that will hold the result from the input file
    function read_initFileInt(varName) result(varValue)
  
      implicit none
      character(len=*),intent(IN) :: varName
      integer :: varValue
  
      integer :: i,openStatus,inputStatus
      integer :: simInitVars
      character(len=maxStrLen) :: simCharVars
      integer :: pos1,pos2
  
      open(unit = 11, file=inFile, status='old',IOSTAT=openStatus,FORM='FORMATTED',ACTION='READ')
  
      do i=1,maxFileLen
        read(11, FMT = 101, IOSTAT=inputStatus) simCharVars
        pos1 = index(simCharVars,varName)
        pos2 = pos1+len_trim(varName)
        if (pos2 > len_trim(varName)) then
          read(simCharVars(pos2+1:),*)simInitVars
          varValue = simInitVars
        endif
      end do
  
      close(11)
  
  101 FORMAT(A, 1X, I5)
  
    end function read_initFileInt
  
    ! subroutine: read_initFileReal
    ! purpose: Pull one real value from an input file
    ! inputs: varName -- String that names the variable, this must be first entry on a line
    ! outputs: varValue -- Real value that will hold the result from the input file
    function read_initFileReal(varName) result(varValue)
  
      implicit none
      character(len=*),intent(IN) :: varName
      real (fp) :: varValue
  
      integer :: i,openStatus,inputStatus
      real :: simInitVars
      character(len=maxStrLen) :: simCharVars
      integer :: pos1,pos2
  
      open(unit = 10, file=inFile, status='old',IOSTAT=openStatus,FORM='FORMATTED',ACTION='READ')
  
      do i=1,maxFileLen
        read(10, FMT = 100, IOSTAT=inputStatus) simCharVars
        pos1 = index(simCharVars,varName)
        pos2 = pos1+len_trim(varName)
        if (pos2 > len_trim(varName)) then
          read(simCharVars(pos2+1:),*)simInitVars
          !print*,varName,len_trim(varName)
          !print*,simCharVars
          !print*,pos1,pos2,simCharVars(pos2+1:),simInitVars;stop
          varValue = simInitVars
        endif
      end do
  
      close(10)
  
  100 FORMAT(A, 1X, F3.1)
  
    end function read_initFileReal
    
    ! subroutine: read_initFileChar
    ! purpose: Pull one string with no spaces from an input file
    ! inputs: varName -- String that names the variable, this must be first entry on a line
    ! outputs: varValue -- String that will hold the result from the input file
    subroutine read_initFileChar(varName,varValue)
  
      implicit none
      character(len=*),intent(IN)  :: varName
      character(len=*),intent(OUT) :: varValue
  
      integer :: i,openStatus,inputStatus
      character(len=maxStrLen) :: simInitVars
      character(len=maxStrLen) :: simCharVars
      integer :: pos1,pos2
  
      open(unit = 13, file=inFile, status='old',IOSTAT=openStatus,FORM='FORMATTED',ACTION='READ')
  
      do i=1,maxFileLen
        read(13, FMT = 103, IOSTAT=inputStatus) simCharVars
        pos1 = index(simCharVars,varName)
        pos2 = pos1+len_trim(varName)
  
        if (pos2 > len_trim(varName)) then
          read(simCharVars(pos2+1:),*)simInitVars
          varValue = simInitVars
        endif
      end do
  
      close(13)
  
  103 FORMAT(A, 1X, A)
  
    end subroutine read_initFileChar
  
  end module setup_module