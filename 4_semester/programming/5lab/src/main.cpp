
#include "libs.h"
#include "Window.h"
#include "App.h"

int CALLBACK WinMain(
    HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR lpCmdLine,
    int nCmdShow
)
{

    if(!App::registration(hInstance,nCmdShow)){
        return 0;
    }
    
    MSG msg = App::run();



    return (int)msg.wParam;
} 

