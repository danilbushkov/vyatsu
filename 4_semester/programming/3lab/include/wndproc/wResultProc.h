#ifndef RESULT_PROC_H
#define RESULT_PROC_H


class WResultProc{
    public:
        static HWND parentHwnd;
        static HWND window;
        static HWND inputSize;
        static HWND label;
        static HWND button;
        static int flag;
        static HWND buttonApply;
        static int matrix[25][25];
        static int matrixLen;
        static HWND matrixResult[25][25];
        static LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

        


        
};


#endif