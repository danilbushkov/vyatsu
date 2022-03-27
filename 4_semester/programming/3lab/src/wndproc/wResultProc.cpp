#include "libs.h"

#include "Window.h"
#include "wResultProc.h"

HWND WResultProc::parentHwnd;
HWND WResultProc::window;
HWND WResultProc::label;
HWND WResultProc::button;
int WResultProc::flag;
wchar_t WResultProc::buffer[2][100];
HWND WResultProc::input[2];
int WResultProc::matrix[25][25];
int WResultProc::matrixLen;
HWND WResultProc::matrixResult[25][25];

LRESULT CALLBACK WResultProc::wProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    int x=20,y=50;
    int w = 20, h = 20;
    HWND tmp;

    RECT rect;
    GetWindowRect(hWnd, &rect);
    int wb,hb;
    wb = rect.right - rect.left;
    hb = 250;
    switch ( uMsg ) {
    case WM_CREATE:
        
        for(int i = 0; i<matrixLen; i++){
                        for(int j = 0; j<matrixLen; j++){


                            matrixResult[i][j] = CreateWindow(L"Static", L"",
        WS_CHILD | WS_VISIBLE | WS_BORDER,
        x, y, w, h, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE),NULL);
                            if(matrix[i][j]==1){
                                SetWindowTextW(matrixResult[i][j],L"1");
                            }
                            x+=20;
                        }
                        x=20;
                        y+=20;
                        
                    }
                    
        


        button = CreateWindowExW(0,L"button", L"Проверить",
            WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 
            200, 
            550, 
            hb, 
            30, 
            hWnd, 
            0, 
            (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), 
            NULL);

        input[0] = CreateWindowExW(0,L"Edit", L"",
        WS_CHILD | WS_VISIBLE |WS_TABSTOP | ES_AUTOHSCROLL | WS_BORDER,
        20, 550, 30, 20, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);

        input[1] = CreateWindowExW(0,L"Edit", L"",
        WS_CHILD | WS_VISIBLE |WS_TABSTOP | ES_AUTOHSCROLL | WS_BORDER,
        70, 550, 30, 20, hWnd, 0, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);

        break;
    case WM_COMMAND:
        size_t i;
        int j, b ,e ,x,y;
        int a;
        for(int i=0; i<2 && flag==0; i++){
            
            if(lParam == (int)input[i]){
                tmp=input[i];
                a = i;
                break;
            }
            
            
        }


        if( lParam == (int)tmp && flag==0 ){
            wchar_t bf[100],bf1[100];
            
            if(HIWORD(wParam)==EN_UPDATE){
                flag=1; 
                SendMessage(tmp, EM_GETSEL, (WPARAM)&b, (LPARAM)&e);
                GetWindowTextW(tmp, bf, 99 ); 
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
                            wcscpy(buffer[a],bf1);
                        }
                    }
                }
                

                SetWindowTextW(tmp,buffer[a]);
                SendMessage(tmp,EM_SETSEL,b,b);
            }
        }else{
            flag=0;
        }
        if(lParam==(int)button){
            if(HIWORD(wParam)==BN_CLICKED){
                
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