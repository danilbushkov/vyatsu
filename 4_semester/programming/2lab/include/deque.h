#ifndef STR_H
#define STR_H
 
#include "node.h"


class Deque{
    private:
        node *first=nullptr;
        node *last=nullptr;

        void deleteNode(node*);
    public:
        void PushFront(data);
        void PushBack(data);
        bool PopFront(data&);
        bool PopBack(data&);
        bool IsEmply();
        void Clear();
        
};
 
#endif