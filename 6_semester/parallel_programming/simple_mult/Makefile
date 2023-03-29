all: gen mult check



gen: bin src/main_gen.cpp
	g++ src/main_gen.cpp -o bin/gen

mult: bin src/main_mult.cpp
	g++ src/main_mult.cpp -o bin/mult

check: bin src/main_check.cpp 
	g++ src/main_check.cpp -o bin/check

fft: bin src/main_fft.cpp 
	g++ src/main_fft.cpp -o bin/fft

bin: 
	mkdir bin


	