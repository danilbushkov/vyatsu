#include <iostream>
#include <cmath>
#include <limits.h>
#include <iomanip> 


const int LEN_STR=100000;

//структруа для хранения вектора
struct Vector{
    int len;
    int *arr;
};

struct Position{
    int pos;
    int wt;
};

int lenStr(const wchar_t *str,const wchar_t c);


Position getPos(const wchar_t* str,int a,int b){
    int len=lenStr(str,L'\0');
    int pos=-1;
    int maxC=0;
    int tempC=0;
    int w=1;
    Position p;
    for(int i=len-a;i>=0;i--){

        w=1;
        tempC=0;
        for(int l=i,r=i+b; (l>=0)&&(r<len)&& w ;l--,r++){
            if(str[r]==str[l]){
                tempC++;
                if((l==0)||(r==len-1)){
                    if(tempC>maxC){
                        maxC=tempC;
                        pos=i;
                    }
                }
            }else{
                w=0;
            }
        }
    }
    
    p.pos=pos;
    p.wt=maxC;
    return p;
}


void offset(wchar_t* str,int c){
    int len = lenStr(str,L'\0');
    for(int i=len-1;i>=0;str[i+c]=str[i--]);
    for(int i=c-1;i>=0;str[i--]=L' ');
    str[len+c]='\0';
}


void getPalindrome(wchar_t *str,int a, int pos){
    
    for(int i=pos+1, j=pos-a; j>=0; i++,j--){
                 str[i]=str[j];
    }
    str[pos*2+1]=L'\0';
}
void getPalindromeBegin(wchar_t *str,int pos,int s){
    int len = lenStr(str,L'\0');
    int shift = len-1-pos*2-s;
    offset(str,shift);
    //std::wcout<<str<<'\n';
    for(int i=pos*2+1+shift+s, j=shift-1; j>=0; i++,j--){
            str[j]=str[i];
    }
   
}



//перегрузка
void Task(wchar_t *str){
    int len = lenStr(str,L'\0');
    Position posTwo = getPos(str,2,1);
    Position posOne = getPos(str,1,0);
    Position pos;
    

    if(posTwo.wt>=posOne.wt){
        if(posTwo.pos>=(len/2)){
            getPalindrome(str,2,posTwo.pos+1);
        }else{
            
            getPalindromeBegin(str,posTwo.pos,1);
        }
        
    }else{
        if(posOne.pos>=(len/2)){
            getPalindrome(str,1,posOne.pos);
        }else{
            
            getPalindromeBegin(str,posOne.pos,0);
        }
        
    }    

    

    

}
double Task(int *arr,int len){
    double sumSqrt = 0;
    for(int i=0; i<len; i++){
        sumSqrt+=(double)arr[i]*(double)arr[i];
    }
    return sqrt(sumSqrt);
}


//Шаблон
template< typename T >
void printResult( T result, const wchar_t *message )
{
    
    std::wcout << std::setprecision(10);
    std::wcout<< message << result <<L'\n'; 
    std::wcout<<L"Нажмите Enter, чтобы продолжить."; 
    while (std::wcin.get() != '\n');
}



int test();
int checkPalindrome(const wchar_t *str);
// double Task(int *arr,int len);
// void Task(wchar_t *str);
//double vectorModul(int *arr,int len);
//void getPalindrome(wchar_t *str);
int isDigit(const wchar_t *str,int f(const wchar_t));
int checkArg(const wchar_t *str);
int getCountArgs(const wchar_t *str);
void copyStr(const wchar_t *str,wchar_t *newStr);
void removeExcess(const wchar_t *str, wchar_t *newStr, int f(const wchar_t));
void printMenu();
int notSpace(const wchar_t c);
int getArg();
void choose(int code);
int checkOverflow(const wchar_t *str);
int checkBigNumber(const wchar_t *str);
void TaskPalindrome();

int main(){
    std::setlocale(LC_ALL, "Russian_Russia.866");
    //std::wcout<<(wchar_t)towupper(L'1');
    //std::wcout<<test(); return 0;

    int code = 0;
    do{
        printMenu();
        code=getArg();
        choose(code);

    }while(code != 3);
    
    return 0;
}

int checkVector(const wchar_t *str){
    if(getCountArgs(str)==0){
        std::wcout<<L"Ошибка: Вектор пуст.\n";
        return 0; 
    }
    if(!isDigit(str,[](const wchar_t c)->int{return( (c!=L' ')&&(c!=L'-') );} )){
        std::wcout<<L"Ошибка: В вектрое есть не число.\n";
        return 0; 
    }
    if(checkBigNumber(str)){
        std::wcout<<L"Ошибка: Число слишком большое для типа int.\n";
        return 0; 
    }

    return 1;
}

int checkOverflow(const wchar_t *str){
    //std::wcout<<str<<L'\n';
    long int v;
    if((str[0]!='0') && (str[0]!='\0')){
        v=wcstol(str,NULL,10);
        //std::wcout<<str<<L'\n';
        //std::wcout<<v<<L'\n';
        if((errno == ERANGE) || (v>INT_MAX) || (v<INT_MIN)){
            errno=0;
            return 1;
        }
    }
    return 0;
}


int checkBigNumber(const wchar_t *str){
    wchar_t num[LEN_STR]=L"";
    int v;
    for(int i = 1,j = 0; (str[i-1]!=L'\0');i++){
        if(str[i-1]!=L' ' && str[i]!='\0'){
            num[j++]=str[i-1];
        }else{
            if(i!=1){
                if(str[i]==L'\0'){
                    num[j++]=str[i-1];
                }
                num[j]=L'\0';
                
                if(checkOverflow(num)){
                    return 1;
                }
                 
            }
            j=0;
        }
    }

    
    return 0;
}

Vector getVector(const wchar_t *str){
    int countArg=getCountArgs(str);
    Vector v;
    v.arr = new int[countArg];
    v.len = countArg;
    wchar_t num[LEN_STR]=L"";
    
    for(int i = 1,j = 0,n=0; (str[i-1]!=L'\0');i++){
        if(str[i-1]!=L' ' && str[i]!='\0'){
            num[j++]=str[i-1];
        }else{
            if(i!=1){
                if(str[i]==L'\0'){
                    num[j++]=str[i-1];
                }
                num[j]=L'\0';
                v.arr[n++]=_wtoi(num);
                 
            }
            j=0;
        }
    }

    return v;
}



void TaskVectorModule(){
    wchar_t str[LEN_STR]=L"";
    wchar_t num[LEN_STR]=L"";
    
    do{
        std::wcout<<L"\nВведите n-мерный вектор: \n";
        std::wcin.getline(str,LEN_STR);
    }while (!checkVector(str));
    
    Vector v = getVector(str);

    
    double result = Task(v.arr,v.len);
    
    delete[] v.arr;

    printResult(result,L"Модуль вектора равен: ");
    
    
}

void choose(int code){
    switch (code)
    {
    case 1:
        
        TaskVectorModule();
        break;
    case 2:
        TaskPalindrome();
        
        break;
    case 3:
        std::wcout<<L"Выход.\n";
        break;
    default:
        std::wcout<<L"Такого пункта меню нет.\n";   
    }
}

void TaskPalindrome(){
    wchar_t str[LEN_STR]=L"";
    wchar_t newstr[LEN_STR]=L"";
    
    
    std::wcout<<L"\nВведите Палиндром: \n";
    std::wcin.getline(str,LEN_STR);
    
    
    removeExcess(str,newstr,[](wchar_t ch)->int{
        return (
            ((ch>=L'0') && (ch<=L'9')) || 
            (std::iswalpha(ch))
        );
    });
    
    

    

    if(checkPalindrome(newstr)){
        
        printResult(L"", L"Вы ввели Палиндром!\n");
    }else{
        Task(newstr);
        
        printResult(newstr,L"Вы ввели не Палиндром! Палиндром должен выглядеть так:\n");
        
    }
    
    
    
}





void printMenu(){
    std::wcout<<L"\n\n==========================\n";
    std::wcout<<L"Меню:\n";
    std::wcout<<L"1. Найти модуль n-мерного вектора.\n";
    std::wcout<<L"2. Проверить на палиндром.\n";
    std::wcout<<L"3. Выйти.\n";
}


int getArg(){
    wchar_t str[LEN_STR];
    wchar_t newstr[LEN_STR];
    int code;
    int work=1;
    do
    {

        std::wcout<<L"\nВыберите пункт меню: ";
        std::wcin.getline(str,LEN_STR);
        if(checkArg(str)){
            removeExcess(str,newstr,notSpace);
            code = _wtoi(newstr);
            if((code>3)||(code<1) ){
                std::wcout<<L"Ошибка: Такого пункта нет. \n";
            }else{
                work=0;
            }

        }
        
    } while (work);
    

    return code;
}



int checkArg(const wchar_t *str){
    if(getCountArgs(str)>1){
        std::wcout<<L"Ошибка: Слишком много аргументов.\n";
        return 0;
    }

    if(!isDigit(str,[](const wchar_t c)->int{return( (c!=L' ')&&(c!=L'-') );} )){
        std::wcout<<L"Ошибка: Введено не число.\n"; 
        return 0;
    }
    return 1;
}


void removeExcess(const wchar_t *str, wchar_t *newStr, int f(const wchar_t)){
    
    int j=0;
    for(int i=0; str[i]!=L'\0'; i++){
        if(f(str[i])){
            newStr[j++]=str[i];
        }
    }
    newStr[j]=L'\0';

}



void copyStr(const wchar_t *str,wchar_t *newStr){
    int i=0;
    for(;str[i]!=L'\0';i++){
        newStr[i]=str[i];
    }
    newStr[++i]=L'\0';
    
}



int getCountArgs(const wchar_t *str){
    int countArgs = 0;

    if( (str[0]!=L' ') && (str[0]!=L'\0') ){
        countArgs++;
    }

    for(int i=1; str[i]!=L'\0';i++){
        if((str[i-1]==L' ') && (str[i]!=L' ')){
            countArgs++;
        }
    }
    return countArgs;
}


int isDigit(const wchar_t *str,int f(const wchar_t)){
    int len;
    for(len=0;str[len]!='\0';len++){
        if((!iswdigit(str[len])) && f(str[len])){
            return 0;
        }
    }
    return 1;

}





int checkPalindrome(const wchar_t *str){
    for(int i=0,j=lenStr(str,L'\0')-1; i<=j ;i++, j--){
        if( (str[i]!=str[j]) 
            && (str[j]!=(wchar_t)towupper(str[i])) 
            && (str[j]!=(wchar_t)towlower(str[i]))){
            return 0;
        }
    }
    return 1;
}

int lenStr(const wchar_t *str,const wchar_t c){
    int len;
    for(len=0;str[len]!=c;len++);
    return len;
}



int notSpace(const wchar_t c){
    return c!=L' ';
}



int test(){
    wchar_t s[LEN_STR] = L"0 0 0 0 0 0 sdf sdfsd sdf";
    wchar_t newS[LEN_STR] = L"";
    if(lenStr(L"",L'\0')!=0) return 1;
    if(lenStr(L"фывапролке",L'\0')!=10) return 1;
    if(lenStr(L"фффффффффффф",L'\0')!=12) return 1;
    if(lenStr(L"ффффф ффф aффпфф",L'\0')!=16) return 1;

    if(!checkPalindrome(L"101")) return 2;
    if(!checkPalindrome(L"1001")) return 2;
    if(checkPalindrome(L"adddddaa")) return 2;
    if(!checkPalindrome(L"ффффффф")) return 2;
    if(!checkPalindrome(L"фффффф")) return 2;

    int arr[] = {10,20,30};
    if( abs(Task(arr,3)-37.4165738677)>0.000000001) return 3;
    if( abs(Task(arr,3)-32.4165738677)<0.000000001) return 3;
    
    
    //getPalindrome(s);
    
    
    if(!isDigit(L"123",notSpace)) return 5;
    if(isDigit(L"123a",notSpace)) return 5;
    if(isDigit(L"123 a",notSpace)) return 5;
    if(isDigit(L"123.3",notSpace)) return 5;
    if(!isDigit(L"1233 ",notSpace)) return 5;
    if(!isDigit(L"1 233 ",notSpace)) return 5;



    if(getCountArgs(L"1 2 3 4")!=4) return 6;
    if(getCountArgs(L"1 2 3")!=3) return 6;
    if(getCountArgs(L"1 2 3 4 10 20 30")!=7) return 6;
    if(getCountArgs(L"1 2рррр 3 6a ф")!=5) return 6;
    if(getCountArgs(L" 1 2рррр 3 6a ф")!=5) return 6;


    removeExcess(s,newS,[](const wchar_t c)->int{
        return c!=L' ';
    });
    //std::wcout<<newS;
    if(checkBigNumber(L"1 2 3 4 5 6")) return 7;
    if(checkBigNumber(L"")) return 7;
    if(checkBigNumber(L" ")) return 7;
    if(checkBigNumber(L"12 34 ")) return 7;
    if(checkBigNumber(L"12 34 -13")) return 7;
    if(!checkBigNumber(L"64985394566")) return 7;
    if(checkBigNumber(L"-2147483648")) return 7;
    if(!checkBigNumber(L"-4147483650")) return 7;
    if(!checkOverflow(L"-2147483649")) return 7;

    //if(getPosTwo("rtyy"))return 7;

    // std::wcout<<getPosTwo(L"rtyy")<<'\n';
    // std::wcout<<getPosTwo(L"ryyty")<<'\n';
    // std::wcout<<getPosTwo(L"yyryyty")<<'\n';

    return 0;
}