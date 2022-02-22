#include <iostream>

#include "deque.h"
#include "shell.h"

int main(){
	setlocale(LC_ALL, "Russian_Russia.866");
    Deque deque = Deque();
    Shell shell(&deque);

    shell.Run();

    
    return 0;
}

