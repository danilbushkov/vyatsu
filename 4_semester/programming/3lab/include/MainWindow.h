#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#include "Window.h"

class MainWindow : public Window{
    public:
        HWND hwndButtonInput;
        HWND hwndButtonResult;
        HWND hwndButtonAbout;

        MainWindow(const wchar_t *className,
                   const wchar_t *title,
                   HINSTANCE hInstance, 
                   int nCmdShow) : Window(className,title,hInstance,nCmdShow){}
        
        LRESULT CALLBACK wProc( HWND, UINT, WPARAM, LPARAM);
};


#endif