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
    else if(Str::Equal(cmd,L"address")) PrintAdress();
    else if(Str::Equal(cmd,L""));
    else if(Str::Equal(cmd,L"exit")) return 0;
    else wcout<<L"Такой команды нет\n";

    return 1;
}


void Shell::PrintAdress(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    if(deque->IsEmpty()){
        wcout<<L"Дек пуст\n";
        return;
    }
    wcout<<deque->getFirst()<<L'\n';
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
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }

    dataBuf d = ReadData();
    deque->PushBack(d);
}
void Shell::PushFront(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }

    dataBuf d = ReadData();
    deque->PushFront(d);

}
void Shell::PopBack(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    dataBuf d;
    int code = deque->PopBack(d);
    if(code){
        printData(d);
    }else{
        wcout<<L"Дек пуст\n";
    }
   
    
}
void Shell::PopFront(){
    if(!EmptyArg()){
        wcout<<L"Аргумент не нужен\n";
        return;
    }
    dataBuf d;
    
    int code = deque->PopFront(d);
    if(code){
        printData(d);
    }else{
        wcout<<L"Дек пуст\n";
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
    wcout<<L"pushBack <string or int> - добавить элемент в конец Дека\n";
    wcout<<L"pushFront <string or int> - добавить элемент в начало Дека\n";
    wcout<<L"popBack - взять и удалить элемент с конца Дека\n";
    wcout<<L"popFront - взять и удалить элемент с начала Дека\n";
    wcout<<L"isEmpty - проверить, пуст ли Дек\n";
    wcout<<L"clearDeque - очистить Дек\n";
    wcout<<L"exit - выйти\n";

}

void Shell::printData(dataBuf &d){
    wcout<<L"Элемент:\n";
    wcout<<L"Строка: "<<d.str<<'\n';
    wcout<<L"Число: "<<d.number<<"\n\n";
}

void Shell::printData(data &d){
    wcout<<L"Элемент:\n";
    wcout<<L"Строка: "<<d.str<<'\n';
    wcout<<L"Число: "<<d.number<<"\n\n";
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


dataBuf Shell::ReadData(){
    dataBuf d;
    wchar_t str[Str::MAX_LEN];
    bool w = true;

    wcout<<L"Введите строку: ";
    wcin.getline(str, Str::MAX_LEN);
    Str::DelSpacesFrontAndBack(str);
    Str::copyStr(str,d.str);


    do{

        wcout<<L"Введите число: ";
        wcin.getline(str, Str::MAX_LEN);
        Str::DelSpacesFrontAndBack(str);
        if(Str::IsInt(str)){
            d.number=_wtoi(str);
            w = false;
        }else{
            wcout<<L"Введено не число или число слишком большое: \n";
        }

    }while(w);
    return d;
}