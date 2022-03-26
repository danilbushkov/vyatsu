#ifndef WINDOW_H
#define WINDOW_H

class Window{

    public:
        

        HINSTANCE hInstance;
        int nCmdShow;
        HWND phwnd;
        HWND hwnd;
        MSG msg;
        wchar_t className[100];
        wchar_t title[100];
        WNDPROC wProc;


        Window(){}
        Window(const wchar_t*, const wchar_t*, HINSTANCE ,WNDPROC ,int);
        virtual int registration();
        virtual MSG startWindow();
        virtual void initWindow();
        
};


#endif