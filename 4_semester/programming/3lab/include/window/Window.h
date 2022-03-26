#ifndef WINDOW_H
#define WINDOW_H

#include "libs.h"


class Window{

    public:
        

        HINSTANCE hInstance;
        int nCmdShow;
        HWND hwnd;
        MSG msg;
        wchar_t className[100];
        wchar_t title[100];
        WNDPROC wProc;



        Window(const wchar_t*, const wchar_t*, HINSTANCE ,WNDPROC ,int);
        virtual int registration();
        virtual MSG startWindow();
        virtual void initWindow();
        
};

LRESULT CALLBACK wProc( HWND, UINT, WPARAM, LPARAM);


#endif