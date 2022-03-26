#ifndef INPUT_PROC_H
#define INPUT_PROC_H


class WInputProc{
    public:
        static HWND parentHwnd;
        static HWND window;
        static HWND inputSize;
        static HWND label;
        static HWND button;
        static wchar_t buffer[100];
        static int flag;
        static HWND matrixInput[30][30];
        static LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

        


        
};


#endif