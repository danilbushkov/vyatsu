

#include "libs.h"

LRESULT CALLBACK wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    switch ( uMsg ) {
    case WM_CREATE:
    
        break;
    case WM_SHOWWINDOW:
    
        break;
    case WM_CLOSE:
    
        break;
    case WM_DESTROY:
    
        PostQuitMessage(0);
        break;
    }
    return DefWindowProc( hWnd, uMsg, wParam, lParam );

}