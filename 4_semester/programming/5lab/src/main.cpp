
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

    if(!registration(hInstance,nCmdShow)){
        return 0;
    }
    
    MSG msg = run();



    return (int)msg.wParam;
} 

