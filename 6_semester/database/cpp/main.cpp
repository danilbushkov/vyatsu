#include <QApplication>
#include <QLabel>
#include <QtWidgets/QMainWindow>

#include <filee.h>

int main(int argc, char **argv)
{

    QApplication app(argc, argv);
    QMainWindow qMainWindow;

    Ui::MainWindow mainWindow;

    mainWindow.setupUi(&qMainWindow);
    mainWindow.retranslateUi(&qMainWindow);
    
    qMainWindow.show();


    
    return app.exec();
}

// #include <iostream>

// int main()
// {
//     std::cout << "Hello, World!" << std::endl;
//     return 0;
// }