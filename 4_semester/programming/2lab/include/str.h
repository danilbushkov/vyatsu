#ifndef STR_H
#define STR_H
 
#include <limits.h>
#include <iomanip>
#include <iostream>

class Str{
    private:
        //wchar_t *str;
        //int lenStr;
        
        
        static int countSpacesFront(const wchar_t*);
    public:
        static const int MAX_LEN = 100000;

        //Str(wchar_t*);

        static void DelSpacesFront(wchar_t*);
        static int Len(const wchar_t*);
        static bool Equal(const wchar_t*, const wchar_t*);
        static void DelSpacesBack(wchar_t*);
        static void DelSpacesFrontAndBack(wchar_t*);
        static bool isDigit(const wchar_t *,int (const wchar_t));
        static bool checkOverflow(const wchar_t *);
        static bool IsInt(const wchar_t *);
        static void copyStr(const wchar_t *,wchar_t *);
};
 
#endif