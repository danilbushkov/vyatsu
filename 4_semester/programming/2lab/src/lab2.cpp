#include <iostream>

#include "deque.h"
#include "shell.h"


using namespace std;


int main(){
    setlocale(LC_ALL, "Russian_Russia.866");
    Deque deque;
    Shell shell(&deque);

    shell.Run();

    
    return 0;
}