/********************************************************************************
** Form generated from reading UI file 'view.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_VIEW_H
#define UI_VIEW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QComboBox>
#include <QtWidgets/QGroupBox>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTableWidget>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;
    QGroupBox *Menu;
    QPushButton *tableButton;
    QPushButton *formButton;
    QGroupBox *tableArea;
    QTableWidget *tableWidget;
    QPushButton *updateFormButton;
    QPushButton *deleteButton;
    QLineEdit *lineEdit;
    QPushButton *filterApplyButton;
    QPushButton *filterCancelButton;
    QLabel *filterLabel;
    QLabel *label_2;
    QGroupBox *addArea;
    QLabel *label1;
    QLabel *label1_2;
    QLineEdit *nameEdit;
    QLabel *label1_3;
    QLineEdit *costEdit;
    QLabel *label1_4;
    QLineEdit *trainingsInput;
    QPushButton *addButton;
    QComboBox *comboBox;
    QLabel *label;
    QPushButton *updateButton;
    QLabel *errorLabel;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(725, 409);
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
        centralwidget->setEnabled(true);
        Menu = new QGroupBox(centralwidget);
        Menu->setObjectName(QString::fromUtf8("Menu"));
        Menu->setGeometry(QRect(0, 10, 141, 361));
        tableButton = new QPushButton(Menu);
        tableButton->setObjectName(QString::fromUtf8("tableButton"));
        tableButton->setGeometry(QRect(0, 10, 141, 31));
        formButton = new QPushButton(Menu);
        formButton->setObjectName(QString::fromUtf8("formButton"));
        formButton->setGeometry(QRect(0, 50, 141, 31));
        tableArea = new QGroupBox(centralwidget);
        tableArea->setObjectName(QString::fromUtf8("tableArea"));
        tableArea->setEnabled(true);
        tableArea->setGeometry(QRect(150, 10, 551, 361));
        tableWidget = new QTableWidget(tableArea);
        tableWidget->setObjectName(QString::fromUtf8("tableWidget"));
        tableWidget->setGeometry(QRect(0, 20, 541, 221));
        updateFormButton = new QPushButton(tableArea);
        updateFormButton->setObjectName(QString::fromUtf8("updateFormButton"));
        updateFormButton->setGeometry(QRect(0, 250, 90, 28));
        deleteButton = new QPushButton(tableArea);
        deleteButton->setObjectName(QString::fromUtf8("deleteButton"));
        deleteButton->setGeometry(QRect(0, 290, 90, 28));
        lineEdit = new QLineEdit(tableArea);
        lineEdit->setObjectName(QString::fromUtf8("lineEdit"));
        lineEdit->setGeometry(QRect(330, 250, 101, 31));
        filterApplyButton = new QPushButton(tableArea);
        filterApplyButton->setObjectName(QString::fromUtf8("filterApplyButton"));
        filterApplyButton->setGeometry(QRect(450, 250, 90, 28));
        filterCancelButton = new QPushButton(tableArea);
        filterCancelButton->setObjectName(QString::fromUtf8("filterCancelButton"));
        filterCancelButton->setGeometry(QRect(450, 290, 90, 28));
        filterLabel = new QLabel(tableArea);
        filterLabel->setObjectName(QString::fromUtf8("filterLabel"));
        filterLabel->setGeometry(QRect(260, 260, 58, 16));
        label_2 = new QLabel(tableArea);
        label_2->setObjectName(QString::fromUtf8("label_2"));
        label_2->setGeometry(QRect(150, 0, 91, 16));
        addArea = new QGroupBox(centralwidget);
        addArea->setObjectName(QString::fromUtf8("addArea"));
        addArea->setEnabled(true);
        addArea->setGeometry(QRect(220, 10, 391, 371));
        label1 = new QLabel(addArea);
        label1->setObjectName(QString::fromUtf8("label1"));
        label1->setGeometry(QRect(150, 10, 91, 16));
        label1_2 = new QLabel(addArea);
        label1_2->setObjectName(QString::fromUtf8("label1_2"));
        label1_2->setGeometry(QRect(10, 50, 151, 16));
        nameEdit = new QLineEdit(addArea);
        nameEdit->setObjectName(QString::fromUtf8("nameEdit"));
        nameEdit->setGeometry(QRect(170, 40, 171, 28));
        label1_3 = new QLabel(addArea);
        label1_3->setObjectName(QString::fromUtf8("label1_3"));
        label1_3->setGeometry(QRect(10, 80, 151, 16));
        costEdit = new QLineEdit(addArea);
        costEdit->setObjectName(QString::fromUtf8("costEdit"));
        costEdit->setGeometry(QRect(170, 80, 171, 28));
        label1_4 = new QLabel(addArea);
        label1_4->setObjectName(QString::fromUtf8("label1_4"));
        label1_4->setGeometry(QRect(10, 120, 151, 16));
        trainingsInput = new QLineEdit(addArea);
        trainingsInput->setObjectName(QString::fromUtf8("trainingsInput"));
        trainingsInput->setGeometry(QRect(170, 120, 171, 28));
        addButton = new QPushButton(addArea);
        addButton->setObjectName(QString::fromUtf8("addButton"));
        addButton->setGeometry(QRect(170, 210, 90, 28));
        comboBox = new QComboBox(addArea);
        comboBox->setObjectName(QString::fromUtf8("comboBox"));
        comboBox->setGeometry(QRect(170, 160, 171, 24));
        label = new QLabel(addArea);
        label->setObjectName(QString::fromUtf8("label"));
        label->setGeometry(QRect(10, 160, 58, 16));
        updateButton = new QPushButton(addArea);
        updateButton->setObjectName(QString::fromUtf8("updateButton"));
        updateButton->setGeometry(QRect(170, 210, 90, 28));
        errorLabel = new QLabel(centralwidget);
        errorLabel->setObjectName(QString::fromUtf8("errorLabel"));
        errorLabel->setGeometry(QRect(170, 370, 501, 20));
        MainWindow->setCentralWidget(centralwidget);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "\320\237\321\200\320\270\320\273\320\276\320\266\320\265\320\275\320\270\320\265", nullptr));
        Menu->setTitle(QString());
        tableButton->setText(QApplication::translate("MainWindow", "\320\237\320\276\320\272\320\260\320\267\320\260\321\202\321\214 \321\202\320\260\320\261\320\273\320\270\321\206\321\203", nullptr));
        formButton->setText(QApplication::translate("MainWindow", "\320\224\320\276\320\261\320\260\320\262\320\270\321\202\321\214 \320\264\320\260\320\275\320\275\321\213\320\265", nullptr));
        tableArea->setTitle(QString());
        updateFormButton->setText(QApplication::translate("MainWindow", "\320\230\320\267\320\274\320\265\320\275\320\270\321\202\321\214", nullptr));
        deleteButton->setText(QApplication::translate("MainWindow", "\320\243\320\264\320\260\320\273\320\270\321\202\321\214", nullptr));
        filterApplyButton->setText(QApplication::translate("MainWindow", "\320\237\321\200\320\270\320\274\320\265\320\275\320\270\321\202\321\214", nullptr));
        filterCancelButton->setText(QApplication::translate("MainWindow", "\320\236\321\202\320\274\320\265\320\275\320\270\321\202\321\214", nullptr));
        filterLabel->setText(QApplication::translate("MainWindow", "\320\246\320\265\320\275\320\260 \320\276\321\202", nullptr));
        label_2->setText(QApplication::translate("MainWindow", "\320\220\320\261\320\276\320\275\320\265\320\274\320\265\320\275\321\202\321\213", nullptr));
        addArea->setTitle(QString());
        label1->setText(QApplication::translate("MainWindow", "\320\224\320\276\320\261\320\260\320\262\320\273\320\265\320\275\320\270\320\265", nullptr));
        label1_2->setText(QApplication::translate("MainWindow", "\320\235\320\260\320\267\320\262\320\260\320\275\320\270\320\265 \320\260\320\261\320\276\320\275\320\265\320\274\320\265\320\275\321\202\320\260", nullptr));
        label1_3->setText(QApplication::translate("MainWindow", "\320\246\320\265\320\275\320\260", nullptr));
        label1_4->setText(QApplication::translate("MainWindow", "\320\232\320\276\320\273\320\270\321\207\320\265\321\201\321\202\320\262\320\276 \321\202\321\200\320\265\320\275\320\270\321\200\320\276\320\262\320\276\320\272", nullptr));
        addButton->setText(QApplication::translate("MainWindow", "\320\224\320\276\320\261\320\260\320\262\320\270\321\202\321\214", nullptr));
        label->setText(QApplication::translate("MainWindow", "\320\227\320\260\320\273:", nullptr));
        updateButton->setText(QApplication::translate("MainWindow", "\320\230\320\267\320\274\320\265\320\275\320\270\321\202\321\214", nullptr));
        errorLabel->setText(QString());
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_VIEW_H
