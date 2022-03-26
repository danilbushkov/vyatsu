#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#include "Window.h"

class MainWindow : public Window{
    public:

        MainWindow(const wchar_t *className,
                   const wchar_t *title,
                   HINSTANCE hInstance, 
                   WNDPROC wProc,
                   int nCmdShow) : Window(className,title,hInstance,wProc,nCmdShow){}
};

LRESULT CALLBACK wMainProc( HWND, UINT, WPARAM, LPARAM);

#endif