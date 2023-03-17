all: so

so: matrix.c lib
	gcc -fPIC -shared -o lib/matrix.so matrix.c

lib: 
	mkdir lib