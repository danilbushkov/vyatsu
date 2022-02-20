#ifndef SHELL_H
#define SHELL_H
 
#include "deque.h"

class Shell{
    private:
        Deque *deque;
        wchar_t *cmd;
        wchar_t *arg;
        
    
    public:

        Shell(Deque *);
        void Run();
        void Help();
        void SelectCmd();
};
 
#endif