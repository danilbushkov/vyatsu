all: bin/master bin/slave


bin/master: bin src/master.cpp
	g++ src/master.cpp -o bin/master \
		-Ipvm -Isrc -Lpvm -lpvm3

bin/slave: bin src/slave.cpp
	g++ src/slave.cpp -o bin/slave \
		-Ipvm -Isrc -Lpvm -lpvm3

cp: bin/master bin/slave
	cp ./bin/* ~/pvm3/bin/LINUX64

rm: 
	rm ~/pvm3/bin/LINUX64/*

comp: rm cp

bin: 
	mkdir bin
