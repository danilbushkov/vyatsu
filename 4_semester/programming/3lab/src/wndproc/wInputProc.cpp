#include "libs.h"

#include "wInputProc.h"

HWND WInputProc::window;
HWND WInputProc::parentHwnd;
HWND WInputProc::inputSize;
HWND WInputProc::button;
HWND WInputProc::label;
int WInputProc::flag;
HWND WInputProc::matrixInput[30][30];
wchar_t WInputProc::buffer[100] = L"";

LRESULT CALLBACK WInputProc::wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    HWND tmp;
    int work;
    switch ( uMsg ) {
    case WM_CREATE:
        RECT rect;
        GetWindowRect(hWnd, &rect);
        int w,hb;
        w = rect.right - rect.left;
        hb = 250;
        EnableWindow(parentHwnd, false);

        label = CreateWindow(L"STATIC",NULL,
        WS_CHILD | WS_VISIBLE,
        w/2-hb/2, 40, hb, 40, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);
        SetWindowTextW(label,L"Введите количество врешин (от 2 до 50):");

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
        int j, b ,e;
        work = 1;
        for(int i=0; i<_wtoi(buffer) && work && flag==0; i++){
            for(int j=0;j<_wtoi(buffer) && work; j++){
                if(lParam == (int)matrixInput[i][j]){
                    tmp = matrixInput[i][j];
                    work=0;
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
                SetWindowTextW(tmp,bf1);
                SendMessage(tmp,EM_SETSEL,b,b);
            }else{
            flag=0;
            }
        }


        if(lParam == (int)inputSize && flag==0){

            if(HIWORD(wParam)==EN_UPDATE){
                flag=1; 
                SendMessage(inputSize, EM_GETSEL, (WPARAM)&b, (LPARAM)&e);
                GetWindowTextW(inputSize, bf, 99 ); 
                j=0;
                if(wcslen(bf)>2){
                    MessageBoxExW(hWnd, 
                            L"Число не может быть больше 50!",
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
                            L"Число должно быть от 2 до 50",
                            L"Ошибка", 0, MB_APPLMODAL);
                    }else{
                        int d = _wtoi(bf1);
                        if(d>30){
                            MessageBoxExW(hWnd, 
                                L"Число должно быть от 2 до 50",
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

                int w = 20, h = 20, x=20,y=50;
                if(d>2 && d<31){
                    ShowWindow(button,0);
                    ShowWindow(inputSize,0);
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