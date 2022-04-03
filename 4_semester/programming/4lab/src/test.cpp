// #ifndef UNICODE
// #define UNICODE
// #endif 

// #include "test.h"

// HWND parentHwnd;




// int InputMatrix(HINSTANCE hInstance,HWND hWnd)
// {
//     const wchar_t * wn = L"class2"; 
//     parentHwnd = hWnd;
//     HWND hwndMain; 
//     MSG msg;

    


//     hwndMain = CreateWindowEx( 
//         0,                          
//         wn,                        
//         wn,                         
//         WS_OVERLAPPED | WS_CAPTION |         
//                 WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
                    
                      
//         CW_USEDEFAULT,          
//         CW_USEDEFAULT,            
//         500,                     
//         400,                    
//         hWnd,             
//         NULL,                      
//         hInstance,                           
//         NULL);                 
    
   

   
//     SetForegroundWindow(hwndMain);

//     ShowWindow(hwndMain, SW_SHOWDEFAULT); 
//     UpdateWindow(hwndMain);
    

//     while (GetMessage(&msg, NULL, 0, 0))
//     {
//         TranslateMessage(&msg);
//         DispatchMessage(&msg);
//     }
    
//     return (int)msg.wParam;
// } 

// LRESULT CALLBACK Window2Proc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
// {
//     switch ( uMsg ) {
//     case WM_CREATE:
//         EnableWindow(parentHwnd, false);

//         break;

//     case WM_COMMAND:
        
//         break;
//     case WM_SHOWWINDOW:
//         //MessageBoxExW(0,L"WM_SHOWWINDOW",L"Сообщение", 0, 0);
//         break;
//     case WM_CLOSE:
//         EnableWindow(parentHwnd, true);
//         DestroyWindow(hWnd);
        
//         break;
//     case WM_DESTROY:
//         //MessageBoxExW(0,L"WM_DESTROY",L"Сообщение", 0, 0);
//         PostQuitMessage(0);
//         break;
//     }
//     return DefWindowProc( hWnd, uMsg, wParam, lParam );
// }; 