all: bin/app



bin/app: obj/main.o obj/slave.o
	mpic++ obj/main.o obj/slave.o -o bin/app -Isrc


obj/main.o: obj src/main.cpp 
	mpic++ -c src/main.cpp -o obj/main.o


obj/slave.o: obj src/slave.cpp
	mpic++ -c src/slave.cpp -o obj/slave.o


rm:
	rm obj/*

obj:
	mkdir obj

bin: 
	mkdir bin

run:
	mpiexec -n 2 ./bin/app 
