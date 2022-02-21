#include <iostream>
#include "deque.h"
#include "node.h"


Deque::~Deque(){
    Clear();
}


void Deque::PushFront(data d){
    node *tmp = (node*)malloc(sizeof(node));
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

void Deque::PushBack(data d){
    node *tmp = (node*)malloc(sizeof(node));
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

bool Deque::PopFront(data &d){
    if(IsEmpty()){
        return 0;
    }
    d = first->content;
    deleteNode(first, false);

    return 1;
}
bool Deque::PopBack(data &d){
    if(IsEmpty()){
        return 0;
    }
    d = last->content;
    deleteNode(last, false);



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
void Deque::deleteNode(node *current,bool delStr){
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

        if(delStr){
            if(current->content.str!=nullptr){
                free(current->content.str);
            }
        }

        free(current);
        current = nullptr;

    }
}