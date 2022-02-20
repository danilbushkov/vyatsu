#include <iostream>
#include "str.h"

// Str::Str(wchar_t *str){
//     this->str=str;
// }

bool Str::Equal(const wchar_t *s1, const wchar_t* s2){
    int lenS1 = Len(s1), lenS2 = Len(s2);
    if(lenS1!=lenS2){
        return 0;
    }
    for(int i = 0; (s1[i]!=L'\0') && (s2[i]!=L'\0');i++){
        if(s1[i]!=s2[i]){
            return 0;
        }
    }

    return 1;
}


int Str::Len(const wchar_t *s){
    int len;
    for(len = 0; s[len]!=L'\0'; len++);
    return len;
}

void Str::DelSpacesFront(wchar_t *s){
    int ls = countSpacesFront(s);
    int i;
    for(i = ls; s[i]!=L'\0' ;i++){
        s[i-ls]=s[i];
    }
    s[i-ls]=L'\0';
    
}
void Str::DelSpacesBack(wchar_t *s){
    int l = Len(s);
    if(l>0){
        while((s[l-1]==L' ') && (l>0)){
            --l;
        }
        s[l]=L'\0';
    }
    
}

void Str::DelSpacesFrontAndBack(wchar_t *s){
    DelSpacesBack(s);
    DelSpacesFront(s);
}

int Str::countSpacesFront(const wchar_t *s){
    int len = 0;
    for(;(s[len]==L' ') && (s[len]==L'\0');len++);
    return len;
}
