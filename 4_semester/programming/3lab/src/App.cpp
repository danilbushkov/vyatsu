#include "libs.h"
#include "window.h"
#include "wMainProc.h"
#include "wInputProc.h"
#include "wProc.h"
#include "App.h"


Window App::mainWindow;
Window App::inputWindow;


int App::registration(HINSTANCE hInstance, int nCmdShow){
    mainWindow = Window(L"mainWindow",
                                       L"Главное окно",
                                       hInstance, 
                                       (WNDPROC)&WMainProc::wProc,
                                       nCmdShow);
    inputWindow = Window(L"inputWindow",
                                       L"Ввод матрицы",
                                       hInstance, 
                                       (WNDPROC)&WInputProc::wProc,
                                       nCmdShow);
    if(!mainWindow.registration()){
        return 0;
    }
    if(!inputWindow.registration()){
        return 0;
    }
    return 1;
}
MSG App::run(){
    return mainWindow.startWindow();
}
void App::startInputWindow(){
    WInputProc::window = inputWindow.hwnd;
    WInputProc::parentHwnd = mainWindow.hwnd;
    inputWindow.startWindow();
}