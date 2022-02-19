
COMPILER=g++
INCLUDE_PATH=./include

CFLAGS=-c -Wall -I$(INCLUDE_PATH)




all: lab2

lab2: ./obj/lab2.o ./obj/deque.o ./obj/str.o
	$(COMPILER) ./obj/lab2.o ./obj/deque.o ./obj/str.o -o ./bin/lab2 

./obj/lab2.o: ./src/lab2.cpp
	$(COMPILER) $(CFLAGS) -c ./src/lab2.cpp -o ./obj/lab2.o

./obj/deque.o: ./src/deque.cpp
	$(COMPILER) $(CFLAGS) -c ./src/deque.cpp -o ./obj/deque.o

./obj/str.o: ./src/str.cpp
	$(COMPILER) $(CFLAGS) -c ./src/str.cpp -o ./obj/str.o


clean:
	rm -rf ./obj/*.o


