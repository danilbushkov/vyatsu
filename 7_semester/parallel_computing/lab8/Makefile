all: run


run: main
	./main



main: main.o
	gcc main.o -o main -lm

main.o: main.c
	gcc -c main.c -o main.o 
