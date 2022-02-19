#ifndef NODE_H
#define NODE_H
 
struct data{
    int number;
    wchar_t* str;
};


struct node{
    data content;

    node *prev;
    node *next;
};




#endif