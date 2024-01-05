! File: Utility.f90
! Author: Ian May
! Purpose: Define useful constants

module utility
  implicit none

  ! Define selected real kind and constants
  integer, parameter :: fp = selected_real_kind(15)
  integer, parameter :: maxFileLen = 50, maxStrLen = 200
  real(fp), parameter :: pi = acos(-1.0_fp)

  contains
  
  end module utility