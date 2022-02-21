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
    else if(Str::Equal(cmd,L"pushBack")) PushBack();
    else if(Str::Equal(cmd,L"pushFront")) PushFront();
    else if(Str::Equal(cmd,L"popBack")) PopBack();
    else if(Str::Equal(cmd,L"popFront")) PopFront();
    else if(Str::Equal(cmd,L"isEmpty")) IsEmpty();
    else if(Str::Equal(cmd,L"clearDeque")) ClearDeque();
    else if(Str::Equal(cmd,L"print")) PrintDeque();
    else if(Str::Equal(cmd,L""));
    else if(Str::Equal(cmd,L"exit")) return 0;
    else wcout<<L"Такой команды нет\n";

    return 1;
}

void Shell::getCmdAndArg(){
    int lenCmd=0;
    int lenArg=0;
    int l;
    for(lenCmd = 0;(cmd[lenCmd]!=L' ') && (cmd[lenCmd]!=L'\0');lenCmd++);
    for(l=lenCmd;(cmd[l]==L' ')&&(cmd[l]!=L'\0') ;++l);
    for(int i=l;cmd[i]!=L'\0';i++){
            arg[lenArg++]=cmd[i];
    }
    arg[lenArg]=L'\0';
    cmd[lenCmd]=L'\0';
}


void Shell::PushBack(){
    if(EmptyArg()){
        wcout<<L"Аргумент пуст\n";
        return;
    }

    data d;

    if(Str::IsInt(arg)){
        d.number=_wtoi(arg);
    }else{
        d.str=(wchar_t*) malloc((Str::Len(arg)+1)*sizeof(wchar_t));
        Str::copyStr(arg,d.str);
    }
    deque->PushBack(d);
}
void Shell::PushFront(){
    if(EmptyArg()){
        wcout<<L"Аргумент пуст\n";
        return;
    }

    data d;

    if(Str::IsInt(arg)){
        d.number=_wtoi(arg);
    }else{
        d.str=(wchar_t*) malloc((Str::Len(arg)+1)*sizeof(wchar_t));
        Str::copyStr(arg,d.str);
    }
    deque->PushFront(d);

}
void Shell::PopBack(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    data d;

    deque->PopBack(d);
    printData(d);
    if(d.str!=nullptr){
        free(d.str);
    }
}
void Shell::PopFront(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    data d;

    deque->PopFront(d);
    printData(d);
    if(d.str!=nullptr){
        free(d.str);
    }
}
void Shell::IsEmpty(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    if(deque->IsEmpty()){
        wcout<<L"Дек пуст\n";
    }else{
        wcout<<L"Дек не пуст\n";
    }
}
void Shell::ClearDeque(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    deque->Clear();

}

bool Shell::EmptyArg(){
    return Str::Equal(arg,L"");
}


void Shell::help(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
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

void Shell::printData(data &d){
    if(d.str==nullptr){
        wcout<< d.number <<L'\n';
    }else{
        wcout<< d.str <<L'\n';
    }
}


void Shell::PrintDeque(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    if(deque->IsEmpty()){
        wcout<<L"Дек пуст\n";
        return;
    }
    node *n = deque->getFirst();
    for(;n != nullptr;){
        printData(n->content);
        n=n->next;
    }
}