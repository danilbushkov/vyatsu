

#include "libs.h"
#include "Window.h"

int CALLBACK WinMain(
    HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR lpCmdLine,
    int nCmdShow
)
{

    // HWND hwndMain; 
    // MSG msg;

    
    // if(!RegisterWindow(wn,WindowProc,hInstance)){
    //     return 0;
    // }
    // if(!RegisterWindow(L"class2",Window2Proc,hInstance)){
    //     return 0;
    // }


    // hwndMain = CreateWindowEx( 
    //     0,                            
    //     wn,                             
    //     wn,                          
    //     WS_OVERLAPPED | WS_CAPTION |           
    //             WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
                
               
    //     CW_USEDEFAULT,         
    //     CW_USEDEFAULT,         
    //     500,                     
    //     400,                     
    //     NULL,            
    //     NULL,                      
    //     hInstance,                            
    //     NULL);                  
    
    
    
    // ShowWindow(hwndMain, nCmdShow); 
    // UpdateWindow(hwndMain);

    // while (GetMessage(&msg, NULL, 0, 0))
    // {
    //     TranslateMessage(&msg);
    //     DispatchMessage(&msg);
    // }
    Window mainWindow = Window(L"mainWindow",
                                       L"Главное окно",
                                       hInstance, 
                                       nCmdShow);

    if(!mainWindow.registration()){
        return 0;
    }
    MSG msg = mainWindow.startWindow();



    return (int)msg.wParam;
} 

