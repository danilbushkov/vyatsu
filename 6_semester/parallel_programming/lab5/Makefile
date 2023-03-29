all: bin/master


bin/master: bin src/master.cpp
	g++ src/master.cpp -o bin/master \
		-Ipvm -Lpvm -lpvm3

bin/slave: bin src/slave.cpp
	g++ src/slave.cpp -o bin/slave \
		-Ipvm -Lpvm -lpvm3

cp:
	cp ./bin/* ~/pvm3/bin/LINUX64


bin: 
	mkdir bin
