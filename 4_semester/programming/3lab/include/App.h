#ifndef App_H
#define APP_H


class App{
    public:
        static Window mainWindow;
        static Window inputWindow;


        static int registration(HINSTANCE,int);
        static MSG run();
        static void startInputWindow();
};

#endif