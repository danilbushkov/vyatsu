


test: 
	python3 test.py

run-cmatrix: 
	python3 cmatrix_test.py

run-server:
	python3 server.py

run-client:
	python3 client.py

so: clang/matrix.c clang/lib
	gcc -fPIC -shared -o clang/lib/matrix.so clang/matrix.c

clang/lib: 
	mkdir clang/lib

