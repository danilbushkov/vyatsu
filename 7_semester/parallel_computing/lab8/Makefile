all: run


run: sort
	mpiexec -n 1 ./sort 30


sort: sort.o
	mpicc sort.o -o sort 

sort.o: sort.c
	mpicc -c sort.c -o sort.o 
