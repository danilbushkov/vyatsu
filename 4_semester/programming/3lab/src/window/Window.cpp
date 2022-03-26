
#include "libs.h"
#include "Window.h"





Window::Window(const wchar_t *className,const wchar_t *title,HINSTANCE hInstance, WNDPROC wProc, int nCmdShow){
    this->hInstance = hInstance;
    this->nCmdShow = nCmdShow;
    this->wProc = wProc;
    wcscpy(this->title,title);
    wcscpy(this->className, className);
    this->phwnd = NULL;
}



void Window::initWindow(){
    hwnd = CreateWindowEx( 
        0,                            
        className,                             
        title,                          
        WS_OVERLAPPED | WS_CAPTION |           
                WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
                
                
        CW_USEDEFAULT,         
        CW_USEDEFAULT,         
        600,                     
        700,                     
        phwnd,            
        NULL,                      
        hInstance,                            
        NULL);   
}

MSG Window::startWindow(){
    initWindow();
    
    ShowWindow(hwnd, nCmdShow); 
    UpdateWindow(hwnd);

    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return msg;
}


int Window::registration(){
    WNDCLASSEXW wc; //струкутра для регистрации класса окон

    wc.cbSize = sizeof(WNDCLASSEX);
    wc.hIconSm = 0;
    wc.style = CS_HREDRAW|CS_VREDRAW;
    wc.lpfnWndProc = wProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hInstance;
    wc.hIcon = (HICON)(LoadImage(hInstance, IDI_APPLICATION, 0,0,0,0));
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
    wc.lpszMenuName = 0;
    wc.lpszClassName = className; 
    
    
    if(!RegisterClassEx(&wc)){
        MessageBoxExW(0,L"Ошибка регистрации!",L"Сообщение", 0, 0);
        return 0;
    };
    return 1;
}
