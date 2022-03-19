#ifndef UNICODE
#define UNICODE
#endif 

#include "test.h"

HWND parentHwnd;




int InputMatrix(HINSTANCE hInstance,HWND hWnd)
{
    const wchar_t * wn = L"class2"; 
    parentHwnd = hWnd;
    HWND hwndMain; 
    MSG msg;

    


    hwndMain = CreateWindowEx( 
        0,                      // no extended styles           
        wn,           // class name                   
        wn,          // window name                  
        WS_OVERLAPPED | WS_CAPTION |  // overlapped window            
                WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
                //WS_HSCROLL |   // horizontal scroll bar        
                //WS_VSCROLL,    // vertical scroll bar          
        CW_USEDEFAULT,          // default horizontal position  
        CW_USEDEFAULT,          // default vertical position    
        500,          // default width                
        400,          // default height               
        hWnd,            // no parent or owner window    
        NULL,           // class menu used              
        hInstance,                  // instance handle              
        NULL);                  // no window creation data      
    
    // Show the window using the flag specified by the program 
    // that started the application, and send the application 
    // a WM_PAINT message. 

   
    SetForegroundWindow(hwndMain);

    ShowWindow(hwndMain, SW_SHOWDEFAULT); 
    UpdateWindow(hwndMain);
    

    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    
    return (int)msg.wParam;
} 

LRESULT CALLBACK Window2Proc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    switch ( uMsg ) {
    case WM_CREATE:
        EnableWindow(parentHwnd, false);

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