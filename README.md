# Fermi-Pasta-Ulam-Tsingou Class Problem

My final project for Applied Mathematics 129: Foundations of Scientific Computing at University of California, Santa Cruz was to create a simulation of the Fermi-Pasta-Ulam-Tsingou (FPUT) problem. This simulation demonstrates both nonlinear and linear versions of the FPUT problem.

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

`make`

Next, run the Fortran code to compute the values. We use the input_file.txt
to input specific parameters:

`./fput.ex input_file.txt`

This will then display all of the necessary variables used for the execution of the
code. It will also return the sol.dat file with all of the necessary data.

Then we just have to run plot.py, which already has sol.dat implemented in the code.

`python3 plot.py`

As the code is setup currently it will save two plots. One of all the masses and the
other one of a single masses. 

You can modify the plot.py file to choose what you would like to plot out specifically. 
There is already certain code commented out to show you what you could potentially plot out.

I have also included some images with a short explaination attached.

# Images

The following two images show how accurate the numerical solution is when compared to an
exact solution. The first one is with 100 time steps versus 419 time steps.
