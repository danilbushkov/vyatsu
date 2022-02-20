#include <iostream>
#include "shell.h"
#include "deque.h"
#include "str.h"

using namespace std;

Shell::Shell(Deque *d){
    this->deque = d;
}


void Shell::Run(){
    wchar_t s[Str::MAX_LEN];
    do{
        wcout<<L"# ";
        wcin.getline(s, Str::MAX_LEN);
        cmd = s;
        SelectCmd();

    }while(!Str::Equal(s,L"exit"));
    


}

void Shell::SelectCmd(){
    if(Str::Equal(cmd,L"help")) Help();
    else if(Str::Equal(cmd,L"clear")) system("cls");
    else if(Str::Equal(cmd,L"pushback")) wcout<<L"pushb\n";
    


    else wcout<<L"Такой команды нет\n";
}

void Shell::Help(){

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