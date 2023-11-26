all: run


run: main
	./main 4 10 0



main: main.o
	gcc main.o -o main -lm

main.o: main.c
	gcc -c main.c -o main.o 
