

#include "test.h"


LRESULT CALLBACK WindowProc( HWND, UINT, WPARAM, LPARAM);
HWND hb1,hb2,hb3; 



int CALLBACK WinMain(
    HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR lpCmdLine,
    int nCmdShow
)
{
    const wchar_t * wn = L"class1"; 

    HWND hwndMain; 
    MSG msg;

    
    if(!RegisterWindow(wn,WindowProc,hInstance)){
        return 0;
    }
    if(!RegisterWindow(L"class2",Window2Proc,hInstance)){
        return 0;
    }


    hwndMain = CreateWindowEx( 
        0,                            
        wn,                             
        wn,                          
        WS_OVERLAPPED | WS_CAPTION |           
                WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
                
               
        CW_USEDEFAULT,         
        CW_USEDEFAULT,         
        500,                     
        400,                     
        NULL,            
        NULL,                      
        hInstance,                            
        NULL);                  
    
    
    
    ShowWindow(hwndMain, nCmdShow); 
    UpdateWindow(hwndMain);

    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    
    return (int)msg.wParam;
} 

LRESULT CALLBACK WindowProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    int w,h,hb;
    

    switch ( uMsg ) {
    case WM_CREATE:
        RECT rect;
        GetWindowRect(hWnd, &rect);
        w = rect.right - rect.left;
        h = rect.bottom - rect.top;
        hb = 250;
        

        hb1=CreateWindowExW(0,L"button", L"Ввести матрицу смежности",
            WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
            w/2-hb/2, 
            30, 
            hb, 
            30, 
            hWnd, 
            0, 
            (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
            NULL);
        hb2=CreateWindowExW(0,L"button", L"Посмотреть результат",
            WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
            w/2-hb/2, 
            90, 
            hb, 
            30, 
            hWnd, 
            0, 
            (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
            NULL);
        hb3=CreateWindowExW(0,L"button", L"О программе",
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
        if(lParam==(int)hb3){
            if(HIWORD(wParam)==BN_CLICKED){
                
                MessageBoxExW(hWnd, L"Программа для построения матрицы смежности \
и проверки связности двух вершин", L"О программе", 0, MB_APPLMODAL);
                
                //UpdateWindow(hWnd);
            }
        } else if(lParam==(int)hb1){
            if(HIWORD(wParam)==BN_CLICKED){
                
                InputMatrix((HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE),hWnd);
                


                
                //UpdateWindow(hWnd);
            }
        }
        break;
    case WM_SHOWWINDOW:
        //MessageBoxExW(0,L"WM_SHOWWINDOW",L"Сообщение", 0, 0);
        break;
    case WM_CLOSE:
        //MessageBoxExW(0,L"WM_CLOSE",L"Сообщение", 0, 0);
        break;
    case WM_DESTROY:
        //MessageBoxExW(0,L"WM_DESTROY",L"Сообщение", 0, 0);
        PostQuitMessage(0);
        break;
    }
    return DefWindowProc( hWnd, uMsg, wParam, lParam );
}; 