#include "libs.h"

#include "Window.h"
#include "wResultProc.h"

HWND WResultProc::parentHwnd;
HWND WResultProc::window;
HWND WResultProc::inputSize;
HWND WResultProc::label;
HWND WResultProc::button;
int WResultProc::flag;
HWND WResultProc::buttonApply;
int WResultProc::matrix[25][25];
int WResultProc::matrixLen;
HWND WResultProc::matrixResult[25][25];

LRESULT CALLBACK WResultProc::wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    int x=20,y=50;
    int w = 20, h = 20;
    switch ( uMsg ) {
    case WM_CREATE:
        
        for(int i = 0; i<matrixLen; i++){
                        for(int j = 0; j<matrixLen; j++){


                            matrixResult[i][j] = CreateWindow(L"Static", L"",
        WS_CHILD | WS_VISIBLE | WS_BORDER,
        x, y, w, h, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE),NULL);
                            if(matrix[i][j]==1){
                                SetWindowTextW(matrixResult[i][j],L"1");
                            }
                            x+=20;
                        }
                        x=20;
                        y+=20;
                        
                    }
                    
        
        break;
    case WM_COMMAND:

        break;
        
    case WM_SHOWWINDOW:
        //MessageBoxExW(0,L"WM_SHOWWINDOW",L"Сообщение", 0, 0);
        break;
    case WM_CLOSE:
        EnableWindow(parentHwnd, true);
        DestroyWindow(hWnd);
        break;
    case WM_DESTROY:
        //MessageBoxExW(0,L"WM_DESTROY",L"Сообщение", 0, 0);
        PostQuitMessage(0);
        break;
    }
    return DefWindowProc( hWnd, uMsg, wParam, lParam );
}; 