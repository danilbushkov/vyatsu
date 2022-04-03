#include "libs.h"
#include "window.h"
#include "wMainProc.h"
#include "wInputProc.h"
#include "wResultProc.h"
#include "wProc.h"
#include "App.h"


Window App::mainWindow;
Window App::inputWindow;
Window App::resultWindow;
int App::Matrix[25][25];
int App::matrixLen;


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
                                       nCmdShow,WS_OVERLAPPED | WS_CAPTION |           
                WS_SYSMENU);
    resultWindow = Window(L"resultWindow",
                                       L"Проверить связности",
                                       hInstance, 
                                       (WNDPROC)&WResultProc::wProc,
                                       nCmdShow,WS_OVERLAPPED | WS_CAPTION |           
                WS_SYSMENU);                                  
    if(!mainWindow.registration()){
        return 0;
    }
    if(!inputWindow.registration()){
        return 0;
    }
    if(!resultWindow.registration()){
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

void App::startResultWindow(){
    for(int i = 0;i<25;i++){
        for(int j = 0;j<25;j++){
            WResultProc::matrix[i][j] = Matrix[i][j];
        }
    }
    

    WResultProc::matrixLen = matrixLen;
    WResultProc::window = resultWindow.hwnd;
    WResultProc::parentHwnd = mainWindow.hwnd;
    resultWindow.startWindow();
}