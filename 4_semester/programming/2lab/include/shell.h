#ifndef SHELL_H
#define SHELL_H
 
#include "deque.h"
#include "str.h"
#include "node.h"
#include <iostream>

class Shell{
    private:
        Deque *deque;
        wchar_t cmd[Str::MAX_LEN];
        wchar_t arg[Str::MAX_LEN];
        
        void getCmdAndArg();
        void help();
        bool selectCmd();

        void PushFront();
        void PushBack();
        void PopFront();
        void PopBack();
        void IsEmpty();
        void ClearDeque();
        bool EmptyArg();
        void printData(dataBuf&);
		void printData(data&);
        void PrintDeque();
		void PrintAdress();
		dataBuf ReadData();


    public:

        Shell(Deque *);
        void Run();
        
};
 
#endif