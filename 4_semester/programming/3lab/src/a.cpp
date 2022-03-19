
#include "test.h"

int RegisterWindow(const wchar_t *className, WNDPROC wProc,HINSTANCE hInstance){
    WNDCLASSEXW wc; //струкутра для регистрации класса окон

    wc.cbSize = sizeof(WNDCLASSEX);
    wc.hIconSm = 0;
    wc.style = CS_HREDRAW|CS_VREDRAW;
    wc.lpfnWndProc = (WNDPROC)wProc;
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