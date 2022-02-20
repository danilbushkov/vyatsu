#ifndef DEQUE_H
#define DEQUE_H
 
#include "node.h"


class Deque{
    private:
        node *first=nullptr;
        node *last=nullptr;

        void deleteNode(node*);
    
    public:
        ~Deque();

        void PushFront(data);
        void PushBack(data);
        bool PopFront(data&);
        bool PopBack(data&);
        bool IsEmply();
        void Clear();
        
};
 
#endif