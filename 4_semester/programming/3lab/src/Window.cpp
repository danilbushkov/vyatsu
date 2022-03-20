
#include "Window.h"

LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);


Window::Window(const wchar_t *className,const wchar_t *title,HINSTANCE hInstance, int nCmdShow){
    this->hInstance = hInstance;
    this->nCmdShow = nCmdShow;
    wcscpy(this->title,title);
    wcscpy(this->className, className);
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
        500,                     
        400,                     
        NULL,            
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
    wc.lpfnWndProc = (WNDPROC)&wProc;
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


LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    switch ( uMsg ) {
    case WM_CREATE:
    
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

}