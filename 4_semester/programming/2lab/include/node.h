#ifndef NODE_H
#define NODE_H
 
struct node{
    int number;
    wchar_t* str;
    int lenStr;

    node *prev;
    node *next;
};


#endif