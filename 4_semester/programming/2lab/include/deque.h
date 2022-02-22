#ifndef DEQUE_H
#define DEQUE_H
 
#include "node.h"
#include <iostream>

class Deque{
    private:
        node *first;
        node *last;

        void deleteNode(node*);
    
    public:
		Deque();
        ~Deque();

        void PushFront(dataBuf);
        void PushBack(dataBuf);
        bool PopFront(dataBuf&);
        bool PopBack(dataBuf&);
        bool IsEmpty();
        void Clear();
        node* getFirst();
        void PrintDeque();
        
};
 
#endif