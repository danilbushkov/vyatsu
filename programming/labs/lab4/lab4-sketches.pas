program lab4;
uses graph,crt,wincrt,math;
const
    xl=30;
    yt=30;
    sc=1;
    n=10;
var 
    Gd,Gm: integer;
    ch: char;
    mx: real = 0;
    my: real = 0;
    a,b:real;
    ay,by:real;
    xr,yd:integer;
    x0:integer=0;
    y0:integer=0;
    s:string;
    i:integer;
    dx:real=1;
    dy:real=1;
    //c:real=0.1;
    //d,c:real;
    
//GetMaxX
//Setcolor
//ClearDevice

//+1. TODO: начертить оси, подписать их, засечки
//+2. TODO: Вывести кривую.
//+3. TODO: Ограничить кривую, сделать штриховку.
//+4. TODO: Масштабирование графика.
//+5. TODO: Независимое масштабирование графика.
//+6. TODO: Вывод расчета.
procedure Axes(x0,y0,n:integer;a,b,ay,by,mx,my:real);
var 
    //n:integer;
    num:real;
    x,y,i:integer;
    s:string;
    dx,dy:real;
begin
    
    line(0,y0,GetMaxX,y0);//Ox

    line(x0,0,x0,GetMaxY);//Oy
    SetColor(12); 
    SetTextStyle(1, 0, 2); 
    OutTextXY(xr - 20, y0 + 20 , 'X'); 
    OutTextXY(x0 - 20, yt + 10, 'Y');

    SetColor(15); 
    SetTextStyle(1, 0, 1); 

    //n := round((b - a) / dx);
    //if (n mod 2) = 0 then n:=n+1;
    dx:=(b-a)/n;
    for i := 1 to n+1 do
    begin
        num := a + (i - 1) * dx; 
        x := xl + trunc(mx * (num - a)); 
        Line(x, y0 - 3, x, y0 + 3); 
        str(num:0:1, s);    
        if abs(num) > 1e-10 then 
        OutTextXY(x - TextWidth(s) div 2, y0 + 10, s);
    end;
    //n := round((by - ay) / dy); 
    //if (n mod 2) = 0 then n:=n+1;
    dy:=(by-ay)/n;
    for i := 1 to n+1 do
    begin
        num := ay + (i - 1) * dy; 
        
        y := yt - trunc(my * (num - by));    
        Line(x0 - 3, y, x0 + 3, y); 
        str(num:0:1, s);    
        if abs(num) > 1e-10 then 
        OutTextXY(x0 + 7, y - TextHeight(s) div 2, s);
    end;
    OutTextXY(x0 - 10, y0 + 10, '0'); 
    // str(dy, s);
    // OutTextXY(10,10,s);
    // str(ay, s);
    // OutTextXY(10,20,s);
    // str(by, s);
    // OutTextXY(10,30,s);
    // str(n, s);
    // OutTextXY(10,40,s);
end;

Function Func(x: real):real;
begin
    Func:=2*x*x*x+2*x*x+(-2)*x+7;
end;

procedure curveGraph(x0,y0,yt,yd:integer;a,b:real);
var 
    x1:real;
    x:integer;
    y:Int64;
    y1:extended;
begin
    x1 := a; 
    while x1 <= b do
    begin
        y1 := Func(x1); 
        x := x0 + round(x1 * mx); 
        y := y0 - round(y1 * my);
        if (y >= yt-20) and (y <= yd+20) then PutPixel(x, y, 2);
        x1 := x1 + 0.001;
    end;
end;

procedure Hatching(a,b,mx,my:real;x0,y0:integer);
var 
    x1,x2:integer;
    y1,y2:extended;
    x,y:integer;
    x3,y3,yd:extended;
    t:real =0;
    //d:real =0;
begin
    SetColor(9);
    y1:=Func(a);
    x1:=x0 + round(a * mx);
    line(x1,y0,x1,y0 - round(y1 * my));

    y2:=Func(b);
    x2:=x0 + round(b * mx);
    line(x2,y0,x2,y0 - round(y2 * my));
    x3:=a;
    y3:=0;
    //write(Func(6));

    while x3 <= b do
    begin
        y1:=Func(x3);
        x := x0 + round(x3 * mx);
        y3:=0+t;
        //yd:=0;
        // while yd<=y3 do begin
        //     y := y0 - round(yd*my);
        //     PutPixel(x,y,9);
        //     yd:=yd+1;
        // end;
        while y3<=y1 do begin
            y := y0 - round(y3*my);
            //y3:=y3+0.001;
            PutPixel(x, y, 9);
            y3:=y3+1;
        end;
        
        t:=t+0.001;
        //l:=l+1;
        //line(x,y0,x,y0 - round(y1 * my));
        //PutPixel(x, y0-10, 9);
        x3 := x3 + 0.001;
    end;
    //line(x2+10,y0-round((t-1)*my),x2,y0-round(t*my));
    x3:=b;
    //t:=0;
    y3:=t-1;
    while x3 >= a do begin
        x := x0 + round(x3 * mx);
        yd:=y3;
        while yd>=0 do begin
            y := y0 - round(yd*my);
            //y3:=y3+0.001;
            PutPixel(x, y, 9);
            yd:=yd-1;
        end;
        y3:=y3-0.001;
        x3 := x3 - 0.001;
    end;
    SetColor(15);
end;


procedure ScalePlusX(var a,b:real);
begin
    if (a<sc+1e-6) and (b>sc+1e-6) then begin
        a:=round(a+sc);
        b:=round(b-sc);
        //if ((b-a) mod (dx-c)) = 0 then dx:=dx-c;
    end;
end;
procedure ScalePlusY(var ay,by:real);
begin
    if (ay<sc+1e-6) and (by>sc+1e-6) then begin
        ay:=round(ay+sc);
        by:=round(by-sc);
        //if ((by-ay) mod (dy-c)) = 0 then dy:=dy-c;
    end;
    
end;

procedure ScaleMinusX(var a,b:real);
begin
    a:=round(a-sc);
    b:=round(b+sc);
    //if ((b-a) mod (dx+c)) = 0 then dx:=dx+c;
end;

procedure ScaleMinusY(var ay,by:real);
begin
    ay:=round(ay-sc);
    by:=round(by+sc);
    //if ((by-ay) mod (dy+c)) = 0 then dy:=dy+c;
end;

procedure ScalePlus(var a,b,ay,by:real);
begin
    ScalePlusX(a,b);
    ScalePlusY(ay,by);
end;

procedure ScaleMinus(var a,b,ay,by:real);
begin
    ScaleMinusX(a,b);
    ScaleMinusY(ay,by);
end;

// procedure ChangeScale();
// begin
//     if (a mod 25) = 0 then 
//     dx:=trunc(dx-c);
//     if (ay mod 25) = 0 then 
//     dx:=trunc(dx-c);
// end;
procedure ShowInfo();
begin
    OutTextXY(10,785,'Task: 2*x^3+(2)*x^2+(-2)*x+(7)');
    OutTextXY(10,800,'<+> - The approach');
    OutTextXY(10,815,'<-> - The distance');
    OutTextXY(10,830,'<1> - The approach of the x-axis');
    OutTextXY(10,845,'<2> - The distance of the x-axis');
    OutTextXY(10,860,'<3> - The approach of the y-axis');
    OutTextXY(10,875,'<4> - The distance of the y-axis');
    OutTextXY(10,890,'<5> - Show graphic solution');
    OutTextXY(10,905,'<6> - Hatching');
    OutTextXY(10,920,'<Enter> - Exit')
end;


procedure Draw(n:integer;var a,b,ay,by: real;xr,xl,yd,yt:integer; var mx,my:real;var x0,y0:integer);
begin
    
    mx := (xr - xl) / (b - a); 
    my := (yd - yt) / (by - ay); 
    x0 := trunc(abs(a) * mx) + xl;
    y0 := yd - trunc(abs(ay) * my);
    Axes(x0,y0,n,a,b,ay,by,mx,my);
    curveGraph(x0,y0,yt,yd,a,b);
    ShowInfo();
end;

procedure Task(a,b,n,mx,my:real;x0,y0:integer);
var 
    x1,x2:integer;
    y1,y2:integer;
    x,y:extended;
    step:real;
begin

    SetColor(13);
    // y1:=Func(a);
    // x1:=x0 + round(a * mx);
    // line(x1,y0,x1,y0 - round(y1 * my));

    // y2:=Func(b);
    // x2:=x0 + round(b * mx);
    // line(x2,y0,x2,y0 - round(y2 * my));
    // x3:=a+0.5;
    step:=(b-a)/n;
    x := a;
    y := Func(x);
    x1 := x0 + round(x * mx);
    y1 := y0 - round(y * my);
    x:=x+step;
    while x-(1e-6) <= b do
    begin

        y := Func(x);
        x2 := x0 + round(x * mx);
        y2 := y0 - round(y * my);
        line(x1,y0,x1,y1);
        line(x1,y1,x2,y2);
        x1:=x2;
        y1:=y2;
        x := x + step;
    end;
    line(x1,y0,x1,y1);
    SetColor(15);
end;

begin
    
    Gd:=detect;
    InitGraph(Gd,Gm,'');
    if GraphResult<>0 then Halt();
    
    a:=-10;
    b:=10;
    by:=10;
    ay:=-10;
    xr:=GetMaxX-30;
    yd:=GetMaxY-30;
    // mx := (xr - xl) / (b - a); 
    // my := (yd - yt) / (by - ay); 
    // x0 := trunc(abs(a) * mx) + xl;
    // y0 := yd - trunc(abs(ay) * my);
    Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
    //Hatching(0,9);
    repeat
        ch:= wincrt.readkey; 

        case ch of
            '+': begin
                ClearDevice();
                ScalePlus(a,b,ay,by);
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
            end;
            '-': begin
                ClearDevice();
                ScaleMinus(a,b,ay,by);
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
            end;
            '1': begin
                ClearDevice();
                ScalePlusX(a,b);
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
            end;
            '2':begin
                ClearDevice();
                ScaleMinusX(a,b);
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
            end;
            '3': begin
                ClearDevice();
                ScalePlusY(ay,by);
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
            end;
            '4': begin
                ClearDevice();
                ScaleMinusY(ay,by);
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
            end;
            '5': begin
                ClearDevice();
                
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                Task(-10,10,10,mx,my,x0,y0);
            end;
            '6': begin
                ClearDevice();
                Draw(n,a,b,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                Hatching(-10,10,mx,my,x0,y0);
            end;
        end;
    until ch=#13;
    CloseGraph;
end.


{

Лабораторная работа №4
Работа в графическом режиме

Цель работы: освоить принципы работы в графическом режиме; получить базовые навыки взаимодействия с графическими примитивами.

Задание:
1. Дополнить программу, реализованную в ходе предыдущей лабораторной работы, режимом визуализации.
2. Предусмотреть возможность вывода кривой, ограничивающей фигуру, на координатную плоскость.
3. Реализовать следующие возможности и элементы: масштабирование графика, подписи на осях, вывод информации о задании.
4. Реализовать не менее двух возможностей из представленных: независимое масштабирование по осям, штриховка вычисляемой площади, визуализация численного расчета интеграла.
}