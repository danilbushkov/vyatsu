#include "libs.h"

#include "Window.h"
#include "wInputProc.h"
#include "App.h"

HWND WInputProc::window;
HWND WInputProc::parentHwnd;
HWND WInputProc::inputSize;
HWND WInputProc::buttonApply;
HWND WInputProc::button;
HWND WInputProc::label;
int WInputProc::flag;
int WInputProc::matrix[25][25];
HWND WInputProc::matrixInput[25][25];
wchar_t WInputProc::buffer[100] = L"";

LRESULT CALLBACK WInputProc::wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    HWND tmp;
    int work;
    RECT rect;
    GetWindowRect(hWnd, &rect);
    int w,hb;
    w = rect.right - rect.left;
    hb = 250;
    switch ( uMsg ) {
    case WM_CREATE:
        for(int i = 0; i<25;i++){
            for(int j = 0; j<25;j++){
                matrix[i][j]=0;
            }
        }

        
        EnableWindow(parentHwnd, false);

        label = CreateWindow(L"STATIC",NULL,
        WS_CHILD | WS_VISIBLE,
        w/2-400/2, 10, 400, 20, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);
        SetWindowTextW(label,L"Введите количество врешин (от 2 до 25):");

        inputSize = CreateWindowExW(0,L"Edit", L"",
        WS_CHILD | WS_VISIBLE |WS_TABSTOP | ES_AUTOHSCROLL | WS_BORDER,
        w/2-hb/2, 80, hb, 20, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);

        button = CreateWindowExW(0,L"button", L"Принять",
            WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
            w/2-hb/2, 
            150, 
            hb, 
            30, 
            hWnd, 
            0, 
            (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
            NULL);
        
        break;
    case WM_COMMAND:

        wchar_t bf[100],bf1[100];
        size_t i;
        int j, b ,e ,x,y;
        work = 1;
        for(int i=0; i<_wtoi(buffer) && work && flag==0; i++){
            for(int j=0;j<_wtoi(buffer) && work; j++){
                if(lParam == (int)matrixInput[i][j]){
                    tmp = matrixInput[i][j];
                    work=0;
                    x=j;
                    y=i;
                }
            }
            
        }
        if(lParam == (int)tmp && flag==0){
            if(HIWORD(wParam)==EN_UPDATE){
                flag=1; 
                SendMessage(tmp, EM_GETSEL, (WPARAM)&b, (LPARAM)&e);
                GetWindowTextW(tmp, bf, 99 ); j=0;
                for(i=0; i<wcslen(bf); i++){
                    if(bf[i]!=L'0'&& bf[i]!=L'1')continue;
                    bf1[j]=bf[i]; j++;
                }
                bf1[j]=L'\0';
                if(wcslen(bf1)>1){
                    bf1[1] = '\0';
                }
                if(bf1[0]==L'1'){
                    matrix[y][x]=1;
                }else{
                    matrix[y][x]=0;
                }
                SetWindowTextW(tmp,bf1);
                SendMessage(tmp,EM_SETSEL,b,b);
            }
        }else{
            flag=0;
        }


        if(lParam == (int)inputSize && flag==0){

            if(HIWORD(wParam)==EN_UPDATE){
                flag=1; 
                SendMessage(inputSize, EM_GETSEL, (WPARAM)&b, (LPARAM)&e);
                GetWindowTextW(inputSize, bf, 99 ); 
                j=0;
                if(wcslen(bf)>2){
                    MessageBoxExW(hWnd, 
                            L"Число не может быть больше 25!",
                            L"Ошибка", 0, MB_APPLMODAL);
                    
                }else{
                    for(i=0; i < wcslen(bf); i++){
                        if(bf[i]<L'0'||bf[i]>L'9'){
                            MessageBoxExW(hWnd, 
                            L"Можно вводить только цифры",
                            L"Ошибка", 0, MB_APPLMODAL);
                            continue;
                        }
                        bf1[j]=bf[i]; 
                        j++;
                    }
                    bf1[j]=L'\0';
                    if((!_wtoi(bf1) && wcslen(bf1)!=0) || bf1[0]=='0'){
                    MessageBoxExW(hWnd, 
                            L"Число должно быть от 2 до 25",
                            L"Ошибка", 0, MB_APPLMODAL);
                    }else{
                        int d = _wtoi(bf1);
                        if(d>25){
                            MessageBoxExW(hWnd, 
                                L"Число должно быть от 2 до 25",
                                L"Ошибка", 0, MB_APPLMODAL);
                        }else{
                            wcscpy(buffer,bf1);
                        }
                    }
                }
                

                SetWindowTextW(inputSize,buffer);
                SendMessage(inputSize,EM_SETSEL,b,b);
            }
        }else{
            flag=0;
        }
        if(lParam==(int)button){
            if(HIWORD(wParam)==BN_CLICKED){
                int d = _wtoi(buffer);

                int x=20,y=50;
                if(d>2 && d<26){
                    ShowWindow(button,0);
                    ShowWindow(inputSize,0);
                    buttonApply = CreateWindowExW(0,L"button", L"Принять",
                    WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
                    w/2-hb/2, 
                    550, 
                    hb, 
                    30, 
                    hWnd, 
                    0, 
                    (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
                    NULL);

                    int w = 20, h = 20;
                    SetWindowTextW(label,L"Введите матрицу смежности:");
                    for(int i = 0; i<d; i++){
                        for(int j = 0; j<d; j++){
                            matrixInput[i][j] = CreateWindowExW(0,L"Edit", L"",
        WS_CHILD | WS_VISIBLE |WS_TABSTOP | ES_AUTOHSCROLL | WS_BORDER,
        x, y, w, h, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);
                            x+=20;
                        }
                        x=20;
                        y+=20;
                    }

                    
                }else{
                    //ошибка
                }
                
                
            }
        }
        if(lParam==(int)buttonApply){
            if(HIWORD(wParam)==BN_CLICKED){
                for(int i = 0;i<25;i++){
                    for(int j = 0;j<25;j++){
                        App::Matrix[i][j] = matrix[i][j];
                    }
                }
                App::matrixLen=_wtoi(buffer);
                EnableWindow(parentHwnd, true);
                DestroyWindow(hWnd);
            }
        }
        break;
        
    case WM_SHOWWINDOW:
        //MessageBoxExW(0,L"WM_SHOWWINDOW",L"Сообщение", 0, 0);
        break;
    case WM_CLOSE:
        EnableWindow(parentHwnd, true);
        DestroyWindow(hWnd);
        break;
    case WM_DESTROY:
        //MessageBoxExW(0,L"WM_DESTROY",L"Сообщение", 0, 0);
        PostQuitMessage(0);
        break;
    }
    return DefWindowProc( hWnd, uMsg, wParam, lParam );
}; 