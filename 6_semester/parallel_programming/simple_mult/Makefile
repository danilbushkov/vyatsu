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

ck:
	./bin/check

mt:
	./bin/mult

t1:
	./bin/gen 8192

t2:
	./bin/gen 16384

t3:
	./bin/gen 32768

t4:
	./bin/gen 65536

t5:
	./bin/gen 131072

t6:
	./bin/gen 262144

t7:
	./bin/gen 524288

t8:
	./bin/gen 1048576

t9:
	./bin/gen 2097152

t10:
	./bin/gen 4194304

t11:
	./bin/gen 8388608

t12:
	./bin/gen 16777216

	