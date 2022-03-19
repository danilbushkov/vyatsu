#ifndef TEST_H
#define TEST_H

#ifndef UNICODE
#define UNICODE
#endif 

#include <Windows.h>
#include <tchar.h>

int InputMatrix(HINSTANCE,HWND);
int RegisterWindow(const wchar_t*, WNDPROC, HINSTANCE);
LRESULT CALLBACK Window2Proc( HWND, UINT, WPARAM, LPARAM);

#endif