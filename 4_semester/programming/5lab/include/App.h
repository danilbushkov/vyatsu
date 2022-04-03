#ifndef App_H
#define APP_H


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