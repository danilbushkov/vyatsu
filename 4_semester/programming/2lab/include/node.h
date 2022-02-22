#ifndef NODE_H
#define NODE_H
 
#include "str.h"


struct data{
    int number;
    wchar_t *str;
};

struct dataBuf{
	int number;
	wchar_t str[Str::MAX_LEN];
};


struct node{
	node *prev;
    node *next;
    data content;

    
};




#endif