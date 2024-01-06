# Fermi-Pasta-Ulam-Tsingou Class Problem

Myy final project for Applied Mathematics 129: Foundations of Scientific Computing at University of California, Santa Cruz was to create a simulation of the Fermi-Pasta-Ulam-Tsingou (FPUT) problem. This simulation helps show nonlinear and linear versions of the FPUT problem.

The numerical calculations were performed using Fortran. The data visualization was performed using Python.
utility.f90 and portions of setup_module.f90 were given by my professor Ian May.

##Files included

utility.f90: This is a file that holds all of the constants used throughout the project. It
was provided by my professor Ian May.

fput.f90: This is the main driver that calls on all modules from each file. It
also allocates the necessary matrix needed to store the data. 

setup_module.f90: This module sets up all of the variables that are needed
for the computation steps. This includes the amount of steps taken, amount
of masses included, spring constant, non-linearity alpha value, and a C
value to help faciliate time step size. 

leapfrog_module.f90: This module does all the calculations for the displacement
of each mass. The values are then stored in a matrix which is then returned to 
the main driver file.

output_module.f90: This takes that matrix filled with displacement values and
creates sol.dat that stores all the values. This allows plot.py to perform data
visualization.

parameters.dat: Parameters can be placed in the file, then the setup_module
file will take each parameter listed here.

plot.py: This file takes all of the data created from the fortran code, then
converts it to the proper graphs. 

## How to Run the Code

Include all files in the same directory and then run the following commands.

First we have to make the code:

'make'

Then we want to run the Fortran code to compute our values. We use the input_file.txt
to input specific parameters:

'./fput.ex input_file.txt'
