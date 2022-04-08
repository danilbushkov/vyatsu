#include "list.h"



List::List(){
    begin = nullptr;
    end = nullptr;
}


void List::DeleteNode(Node *node){
    if(node!=nullptr){
        if(node->prev==nullptr){
            begin = node->next;
        }else{
            node->prev->next = node->next;
        }
        
        if(node->next==nullptr){
            end = node->prev;
        }else{
            node->next->prev = node->prev;
        }

        
        if(node->obj!=nullptr){
            delete node->obj;
        }
        delete node;
        node = nullptr;

    }
}

void List::AddNode(MovingObject *obj){
    Node *node = new Node;
    node->obj = obj;
    node->next = nullptr;
    node->prev = end;

    if(begin == nullptr){
        begin = node;
    }else{
        end->next = node;
    }
    end = node;
}

void List::Clear(){
    Node *node = begin;
    while(node != nullptr){
        DeleteNode(node);
        node = begin;
    }
}

List::~List(){
    Clear();
}