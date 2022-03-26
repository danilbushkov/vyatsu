#include "libs.h"
#include "Window.h"
#include "wMainProc.h"
#include "App.h"



HWND WMainProc::hwndButtonAbout;
HWND WMainProc::hwndButtonInput;
HWND WMainProc::hwndButtonResult;


LRESULT CALLBACK WMainProc::wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    int w,hb;
    

    switch ( uMsg ) {
    case WM_CREATE:
        RECT rect;
        GetWindowRect(hWnd, &rect);
        w = rect.right - rect.left;
        hb = 250;
        

        hwndButtonInput=CreateWindowExW(0,L"button", L"Ввести матрицу смежности",
            WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
            w/2-hb/2, 
            30, 
            hb, 
            30, 
            hWnd, 
            0, 
            (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
            NULL);
        hwndButtonResult=CreateWindowExW(0,L"button", L"Посмотреть результат",
            WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
            w/2-hb/2, 
            90, 
            hb, 
            30, 
            hWnd, 
            0, 
            (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
            NULL);
        hwndButtonAbout=CreateWindowExW(0,L"button", L"О программе",
            WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
            w/2-hb/2, 
            150, 
            hb, 
            30, 
            hWnd, 
            0, 
            (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
            NULL);


        break;

    case WM_COMMAND:
        if(lParam==(int)hwndButtonAbout){
            if(HIWORD(wParam)==BN_CLICKED){
                
                MessageBoxExW(hWnd, L"Программа для построения матрицы смежности \
и проверки связности двух вершин", L"О программе", 0, MB_APPLMODAL);
                
                
            }
        } else if(lParam==(int)hwndButtonInput){
            if(HIWORD(wParam)==BN_CLICKED){
                
                
                App::startInputWindow();


                
            }
        } else if(lParam==(int)hwndButtonResult){
            if(HIWORD(wParam)==BN_CLICKED){
                
                
                App::startResultWindow();


                
            }
        }
         break;
    case WM_SHOWWINDOW:
        
        break;
    case WM_CLOSE:
        
        break;
    case WM_DESTROY:
        
        PostQuitMessage(0);
        break;
    }
    return DefWindowProc( hWnd, uMsg, wParam, lParam );
}; 