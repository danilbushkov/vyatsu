#ifndef MAIN_PROC_H
#define MAIN_PROC_H



class WMainProc{
    public:

        static LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

        static HWND hwndButtonResult;
        static HWND hwndButtonInput;
        static HWND hwndButtonAbout;


        
};


#endif