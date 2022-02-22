#include <iostream>
#include "deque.h"
#include "node.h"


Deque::Deque(){
    first = nullptr;
    last = nullptr;
}

Deque::~Deque(){
    Clear();
}


void Deque::PushFront(dataBuf df){
    node *tmp = (node*)malloc(sizeof(node));

    data d;

    d.str = (wchar_t*) malloc((Str::Len(df.str)+1)*sizeof(wchar_t));
    Str::copyStr(df.str,d.str);
    d.number = df.number;


    tmp->content = d;
    tmp->next = first;
    tmp->prev = nullptr;
    if(last == nullptr){
        last = tmp;
    }else{
        first->prev = tmp;
    }


    first = tmp;
}

void Deque::PushBack(dataBuf df){
    node *tmp = (node*)malloc(sizeof(node));

    data d;

    d.str = (wchar_t*) malloc((Str::Len(df.str)+1)*sizeof(wchar_t));
    Str::copyStr(df.str,d.str);
    d.number = df.number;

    tmp->content = d;
    tmp->prev = last;
    tmp->next = nullptr;
    if(first == nullptr){
        first = tmp;
    }else{
        last->next = tmp;
    }

    last = tmp;
}

bool Deque::PopFront(dataBuf &df){
    if(IsEmpty()){
        return 0;
    }
    df.number=first->content.number;
    Str::copyStr(first->content.str,df.str);


    deleteNode(first);

    return 1;
}
bool Deque::PopBack(dataBuf &df){
    if(IsEmpty()){
        return 0;
    }
    df.number=last->content.number;
    Str::copyStr(last->content.str,df.str);

    deleteNode(last);

    return 1;
}
bool Deque::IsEmpty(){
    if(first == nullptr){
        return 1;
    }
    return 0;
}
void Deque::Clear(){
    node *tmp = first;
    while(tmp != nullptr){
        deleteNode(tmp);
        tmp = first;
    }
}
void Deque::deleteNode(node *current){
    if(current!=nullptr){
        if(current->prev==nullptr){
            first = current->next;
        }else{
            current->prev->next = current->next;
        }
        
        if(current->next==nullptr){
            last = current->prev;
        }else{
            current->next->prev = current->prev;
        }

        
        if(current->content.str!=nullptr){
            free(current->content.str);
        }
       
        
        free(current);
        current = nullptr;

    }
}

node* Deque::getFirst(){
    return first;
}