#include <iostream>
#include "shell.h"
#include "deque.h"


using namespace std;

Shell::Shell(Deque *d){
    this->deque = d;
}


void Shell::Run(){
    do{
        wcout<<L"# ";
        wcin.getline(cmd, Str::MAX_LEN);
        Str::DelSpacesFrontAndBack(cmd);
        //wcout<<cmd<<L"|\n";
        getCmdAndArg();

        

    }while(selectCmd());
    


}


bool Shell::selectCmd(){
    if(Str::Equal(cmd,L"help")) help();
    else if(Str::Equal(cmd,L"clear")) system("cls");
    else if(Str::Equal(cmd,L"pushback")) wcout<<L"pushb\n";
    
    else if(Str::Equal(cmd,L""));
    else if(Str::Equal(cmd,L"exit")) return 0;
    else wcout<<L"Такой команды нет\n";

    return 1;
}

void Shell::getCmdAndArg(){
    int lenCmd=0;
    int lenArg=0;
    for(lenCmd = 0;(cmd[lenCmd]!=L' ') && (cmd[lenCmd]!=L'\0');lenCmd++);
    for(int i=lenCmd;cmd[i]!=L'\0';i++){
        if(cmd[i]!=L' '){
            arg[lenArg++]=cmd[i];
        }
    }
    arg[lenArg]=L'\0';
    cmd[lenCmd]=L'\0';
}

void Shell::help(){

    wcout<<L"\nhelp - посмотреть команды\n";
    wcout<<L"clear - очистить консоль\n";
    wcout<<L"pushback <string or int> - добавить элемент в конец Дека\n";
    wcout<<L"pushfront <string or int> - добавить элемент в начало Дека\n";
    wcout<<L"popback - взять и удалить элемент с конца Дека\n";
    wcout<<L"popfront - взять и удалить элемент с начала Дека\n";
    wcout<<L"isempty - проверить, пуст ли Дек\n";
    wcout<<L"cleardeque - очистить Дек\n";
    wcout<<L"exit - выйти\n";

}