#ifndef LIST_H
#define LIST_H

#include "movingObject.h"

struct Node
{
    Node* next;
    Node* prev;
    MovingObject *obj;
};


class List{
    public:
        Node *begin;
        Node *end;
        void DeleteNode(Node *);
        void AddNode(MovingObject*);
        void Clear();
        List();
        ~List();
};



#endif