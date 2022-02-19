
COMPILER=g++
INCLUDE_PATH=./include

CFLAGS=-c -Wall -I$(INCLUDE_PATH)




all: lab2

lab2: ./obj/lab2.o
	$(COMPILER) ./obj/lab2.o -o ./bin/lab2

./obj/lab2.o: ./src/lab2.cpp
	$(COMPILER) $(CFLAGS) -c ./src/lab2.cpp -o ./obj/lab2.o



clean:
	rm -rf ./obj/*.o


