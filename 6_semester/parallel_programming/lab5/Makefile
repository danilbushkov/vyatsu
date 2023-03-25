all: bin/app


bin/app: bin src/main.cpp
	g++ src/main.cpp -o bin/app \
		-Ipvm -Lpvm -lpvm3


bin: 
	mkdir bin