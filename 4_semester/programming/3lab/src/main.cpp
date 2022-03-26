

#include "libs.h"
#include "MainWindow.h"

int CALLBACK WinMain(
    HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR lpCmdLine,
    int nCmdShow
)
{

    MainWindow mainWindow = MainWindow(L"mainWindow",
                                       L"Главное окно",
                                       hInstance, 
                                       (WNDPROC)&wMainProc,
                                       nCmdShow);
    

    if(!mainWindow.registration()){
        return 0;
    }
    MSG msg = mainWindow.startWindow();



    return (int)msg.wParam;
} 

