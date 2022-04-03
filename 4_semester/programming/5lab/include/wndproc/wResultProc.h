#ifndef RESULT_PROC_H
#define RESULT_PROC_H


class WResultProc{
    public:
        static HWND parentHwnd;
        static HWND window;
        static HWND label;
        static HWND button;
        static int flag;
        static HWND input[2];
        static HWND labelInput[2];
        static wchar_t buffer[2][100];
        static int matrix[25][25];
        static int matrixLen;
        static HWND stateH[25];
        static HWND stateV[25];
        static HWND matrixResult[25][25];
        static LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

        


        
};


#endif