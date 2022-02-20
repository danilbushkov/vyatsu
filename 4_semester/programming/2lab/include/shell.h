#ifndef SHELL_H
#define SHELL_H
 
#include "deque.h"
#include "str.h"

class Shell{
    private:
        Deque *deque;
        wchar_t cmd[Str::MAX_LEN];
        wchar_t arg[Str::MAX_LEN];
        
        void getCmdAndArg();
        void help();
        bool selectCmd();
    public:

        Shell(Deque *);
        void Run();
        
};
 
#endif