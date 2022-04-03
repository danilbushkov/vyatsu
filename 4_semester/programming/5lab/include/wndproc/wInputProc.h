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
        static HWND buttonApply;
        static HWND stateH[25];
        static HWND stateV[25];
        static int matrix[25][25];
        static HWND matrixInput[25][25];
        static LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

        


        
};


#endif