FC = gfortran
FFLAGS = -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=5 -g -fcheck=all -fbacktrace
LFLAGS =

OBJ = utility.o setup_module.o leapfrog_module.o output_module.o fput.o

fput.ex: $(OBJ)
	$(FC) -o $@ $^ $(LFLAGS) $(FFLAGS)

%.o: %.f90
	$(FC) -c -o $@ $< $(FFLAGS)

.PHONY: clean

clean:
	rm -f fput.ex $(OBJ) *.mod *~
