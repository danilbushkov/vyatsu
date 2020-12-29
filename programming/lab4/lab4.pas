program lab3;
uses graph,Crt,wincrt;
const
    NORM=LightGray; 
    SEL=Green;  
    ERR=Red;
    N=8;
    eps=1e-6;
    x1=-2.188;
    sc=1;
    xl=30;
    yt=30;
var 
    menu:array[1..N] of string;
    punkt:integer;  
    ch:char; 
    x,y:integer;   
    a: real=0;
    b: real=0;
    c: real=0;
    d: real=0;
    i: real;
    steps: real=0;
    f: boolean = False;
    xr,yd:integer;

Procedure WriteError(str:string);
begin
    crt.TextAttr:=ERR;
    writeln(str);
    crt.TextAttr:=NORM;
end;

Procedure WriteSuccess(str:string);
begin
    crt.TextAttr:=SEL;
    writeln(str);
    crt.TextAttr:=NORM;
end;


Function Func(x: real):real;
begin
    Func:=2*x*x*x+2*x*x+(-2)*x+7;
end;

Function FFunc(x: real):real;
begin
    FFunc:=1/2*x*x*x*x+2/3*x*x*x-x*x+7*x;
end;
//show information
Procedure Information;
begin
    crt.ClrScr;
    writeln('The task:');
    writeln('1. Implement a program for calculating the area of a figure bounded by a curve');
    writeln('2*x^3+(2)*x^2+(-2)*x+(7) and an x-axis(in the positive y-axis).');
    writeln('2. The calculation of the definite integral must be performed numerivally, using the');
    writeln('trapezoid method.');
    writeln('3. Integration limirs are entered by the user.');
    writeln('4. Interaction with the user should be done through the case-menu.');
    writeln('5. It is required to realize the possibility of evaluating the аccuracy of the obtained result.');
    writeln('6. Procedures and functions should be used where appropriate.');
    WriteSuccess('Enter <Enter> for continue');
    repeat
        ch:= crt.readkey; 
    until ch=#13;
end;

//enter limit of integration
Procedure Limit;
begin
    crt.ClrScr;
    write('Enter the start of integration: ');
    Readln(a);
    repeat
        write('Enter the end of integration: ');
        Readln(b);
        if b <= a then begin
            WriteError('The number must be greater than the beginning!');
        end
        else f := True;
    until f;
    f:=False;
    c:=a;
    d:=b;
    if b<x1 then begin
        a:=x1;
        b:=x1;
    end
    else if a<x1 then begin
        a:=x1;
    end;
    WriteSuccess('Done! Enter <Enter> for continue');
    repeat
        ch:= crt.readkey; 
    until ch=#13;
end;

//enter step of integration
Procedure Step;
begin
    ClrScr;
    Write('Enter number of steps: ');
    repeat
        Readln(steps);
        if steps <= 0 then begin
            WriteError('The number steps must be greater than 0! Try again.');
        end;
    until (steps > 0);
    WriteSuccess('Done! Enter <Enter> for continue');
    repeat
        ch:= crt.readkey; 
    until ch=#13;
end;


Function Result:real;
var 
    r:real = 0;
    h:real;
begin
    ClrScr;
    if (a=0) and (b=0) then begin
        WriteError('You have not entered the limits of integration! Enter <Enter> for continue');
    end
    else
    begin
        if steps <= 0 then begin
            WriteError('You did not set the number of steps! Enter <Enter> for continue');
        end
        else begin
            h:=(b-a)/steps;
            i:=a;
            while i+eps < b do begin
                r:= r+(h*(Func(i)+Func(i+h))/2);
                i:=i+h;
            end;
            Exit(r);
        end;
    end;
    Exit(-1);
end;

procedure ShowResult;
var r:real;
var h:real;
begin
    r:=Result;
    if r >= 0-eps then begin
        h:=(b-a)/steps;
        write('The area on the segment [',c:5:2,';',d:5:2,'] with a step ',h:5:2,' is equal to ');
        writeln(r:5:2);
        WriteSuccess('Enter <Enter> for continue.');
    end;
    repeat
        ch:= crt.readkey; 
    until ch=#13;
end;


procedure AbsAcc;
var r,l:real;
begin
    crt.ClrScr;
    r:=Result;
    if r >= 0-eps then begin
        if b-eps <=x1 then begin
            l := 0;
        end
        else begin
            l:=(FFunc(b)-FFunc(a))-r;
        end;
        writeln(abs(l):5:2);
        WriteSuccess('Enter <Enter> for continue.');
    end;
    repeat
        ch:= crt.readkey; 
    until ch=#13;
end;


procedure RelAcc;
var r,l:real;
begin
    crt.ClrScr;
    r:=Result;
    if r >= 0-eps then begin
        if b-eps <=x1 then begin
            l := 0
        end
        else begin
            l:=FFunc(b)-FFunc(a);
            l:=abs((l-r)/l);
        end;
        writeln(l:5:2);
        WriteSuccess('Enter <Enter> for continue.');
    end;

    repeat
        ch:= crt.readkey; 
    until ch=#13;
end;

Procedure MenuToScr;
var i:integer;
begin
    crt.ClrScr;
    for i:=1 to N do 
    begin 
        GoToXY(x,y+i-1);
        write(menu[i]);
    end;
    writeln();
    writeln();
    writeln('[',c:5:2,';',d:5:2,'], number of steps: ',steps:5:2);
    crt.TextAttr:=SEL;
    GoToXY(x,y+punkt-1);
    write(menu[punkt]);
    crt.TextAttr:=NORM;
end;

Procedure ChangeMenu(d:boolean);
begin
    crt.GoToXY(x,y+punkt-1); 
    write(menu[punkt]);
    if d then punkt:=punkt+1
    else punkt:=punkt-1;
    crt.TextAttr:=SEl;
    crt.GoToXY(x,y+punkt-1); 
    write(menu[punkt]);
    crt.TextAttr:=NORM;
end;

//Graphic
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


procedure curveGraph(x0,y0,yt,yd:integer;a,b:real;mx,my:real);
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
    x,y:longint;
    x3,y3,yd:extended;
    t:real =0;
    //d:real =0;
begin
    SetColor(9);
    y1:=Func(a);
    x1:=x0 + round(a * mx);
    y:=y0 - round(y1 * my);
    if y < 0 then y:=0;
    line(x1,y0,x1,y);

    y2:=Func(b);
    
    x2:=x0 + round(b * mx);
    y:=y0 - round(y2 * my);
    // writeln(y0 - round(y2 * my));
    // writeln(y);
    //writeln(y0,' ',getmaxy, ' ', y, ' ',y0 - round(y2 * my));
    if y < 0 then y:=0;
    line(x2,y0,x2,y);
    //writeln(y0 - round(y2 * my));
    x3:=a;
    y3:=0;
    //write(y2);
    //write(Func(6));

    while x3 <= b do
    begin
        y1:=Func(x3);
        x := x0 + round(x3 * mx);
        y3:=0+t;
        y:=1;
        //yd:=0;
        // while yd<=y3 do begin
        //     y := y0 - round(yd*my);
        //     PutPixel(x,y,9);
        //     yd:=yd+1;
        // end;
        while (y3<=y1) and (y>=0) do begin
            y := y0 - round(y3*my);
            //y3:=y3+0.001;
            PutPixel(x, y, 9);
            y3:=y3+2;
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
    y3:=t-2;
    while x3 >= a do begin
        x := x0 + round(x3 * mx);
        yd:=y3;
        while yd>=0 do begin
            y := y0 - round(yd*my);
            //y3:=y3+0.001;
            PutPixel(x, y, 9);
            yd:=yd-2;
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
var st,s:string;
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
    OutTextXY(10,920,'<Enter> - Exit');
    Str(c:5:2,s);
    st:='a = ' +s + '; ';
    Str(d:5:2,s);
    st:=st+'b = ' +s+'; ';
    Str(steps:5:2,s);
    st:=st+'steps = '+s+'; ';
    OutTextXY(10,935, st);
end;

procedure Draw(n:integer;var a,b,ay,by: real;xr,xl,yd,yt:integer; var mx,my:real;var x0,y0:integer);
begin
    
    mx := (xr - xl) / (b - a); 
    my := (yd - yt) / (by - ay); 
    x0 := trunc(abs(a) * mx) + xl;
    y0 := yd - trunc(abs(ay) * my);
    Axes(x0,y0,n,a,b,ay,by,mx,my);
    curveGraph(x0,y0,yt,yd,a,b,mx,my);
    ShowInfo();
end;

procedure Task(a,b,n,mx,my:real;x0,y0:integer);
var 
    x1,x2:longint;
    y1,y2:longint;
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
    if y1 < 0 then y1:=0;
    //line(0,0,)
    x:=x+step;
    while x-(1e-6) <= b do
    begin
        y := Func(x);
        x2 := x0 + round(x * mx);
        y2 := y0 - round(y * my);
        if (y2 < 0) and (y1 <= 0)then y2:=0;
        line(x1,y0,x1,y1);
        
        if(y1 > 0) then line(x1,y1,x2,y2);
        x1:=x2;
        y1:=y2;
        x := x + step;
        
    end;
    line(x1,y0,x1,y1);
    SetColor(15);
end;

procedure CheckTaskAndHatching(t,h:boolean;a,b,n,mx,my:real;x0,y0:integer);
begin
    if t then Task(a,b,steps,mx,my,x0,y0);
    if h then Hatching(a,b,mx,my,x0,y0);
end;

procedure Visualization;
const
    sc=1;
    n=10;
var 
    Gd,Gm: integer;
    ch: char;
    mx: real = 0;
    my: real = 0;
    ax,bx:real;
    ay,by:real;
    x0:integer=0;
    y0:integer=0;
    iT:boolean = false;
    iH: boolean = false;
begin
    Gd:=detect;
    InitGraph(Gd,Gm,'');
    if GraphResult<>0 then Exit();
    
    ax:=-10;
    bx:=10;
    by:=10;
    ay:=-10;
    xr:=GetMaxX-30;
    yd:=GetMaxY-30;
    // mx := (xr - xl) / (b - a); 
    // my := (yd - yt) / (by - ay); 
    // x0 := trunc(abs(a) * mx) + xl;
    // y0 := yd - trunc(abs(ay) * my);
    Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
    //Hatching(0,9);
    repeat
        ch:= wincrt.readkey; 

        case ch of
            '+': begin
                ClearDevice();
                ScalePlus(ax,bx,ay,by);
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
            end;
            '-': begin
                ClearDevice();
                ScaleMinus(ax,bx,ay,by);
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
            end;
            '1': begin
                ClearDevice();
                ScalePlusX(ax,bx);
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
            end;
            '2':begin
                ClearDevice();
                ScaleMinusX(ax,bx);
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
                
            end;
            '3': begin
                ClearDevice();
                ScalePlusY(ay,by);
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
            end;
            '4': begin
                ClearDevice();
                ScaleMinusY(ay,by);
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
            end;
            '5': begin
                ClearDevice();
                
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                if not iT then
                begin
                    iT:=true;
                    
                end
                else iT:=false;
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
            end;
            '6': begin
                ClearDevice();
                Draw(n,ax,bx,ay,by,xr,xl,yd,yt,mx,my,x0,y0);
                if not iH then
                begin
                    iH:=true;
                    
                end
                else iH:=false;
                CheckTaskAndHatching(iT,iH,a,b,n,mx,my,x0,y0);
            end;
        end;
    until ch=#13;
    CloseGraph;
end;
procedure Graphic;
var r:real;
begin
    r:=Result;
    if r >= 0-eps then begin
        Visualization;
        exit;
    end;
    repeat
        ch:= crt.readkey; 
    until ch=#13;
end;

begin
    menu[1]:='Information on the program';    
    menu[2]:='Enter limit of integration';   
    menu[3]:='Enter the number of steps';
    menu[4]:='Result';
    menu[5]:='Absolute accuracy';
    menu[6]:='Relative accuracy';
    menu[7]:='Visualization';
    menu[8]:='Exit';
    punkt:=1;     
    x:=1;     
    y:=1; 
    crt.TextAttr:=NORM;
    MenuToScr;
    repeat 
    ch:=crt.ReadKey;
    if ch=#0 then begin 
        ch:=crt.ReadKey;
        case ch of 
        #80:
            if punkt<N then 
            begin 
                ChangeMenu(true);
            end;
        #72:
            if punkt>1 then 
            begin 
                ChangeMenu(false);
            end;
        end;
        end
        else if ch=#13 then begin
        case punkt of 
            1:Information;
            2:Limit;
            3:Step;
            4:ShowResult;
            5:AbsAcc;
            6:RelAcc;
            7:Graphic;
            8:ch:=#27;
            end;
            MenuToScr;
            end;
    until ch=#27;
    crt.ClrScr;
end.


