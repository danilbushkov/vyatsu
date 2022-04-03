#ifndef App_H
#define APP_H




#ifdef BUILD_DLL
#define DLL extern "C" __declspec(dllexport)
#else
#define DLL extern "C" __declspec(dllimport)
#endif




DLL int registration(HINSTANCE hInstance, int nCmdShow);
DLL MSG run();




class App{
    public:
        static Window mainWindow;
        static Window inputWindow;
        static Window resultWindow;
        static int Matrix[25][25];
        static int matrixLen;


        static int registration(HINSTANCE,int);
        static MSG run();
        static void startInputWindow();
        static void startResultWindow();
};

#endif