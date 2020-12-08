program lab3;
uses Crt;
const
    NORM=LightGray; 
    SEL=Green;  
    ERR=Red;
    N=7;
    eps=1e-6;
    x1=-2.188;
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

Procedure WriteError(str:string);
begin
    TextAttr:=ERR;
    writeln(str);
    TextAttr:=NORM;
end;

Procedure WriteSuccess(str:string);
begin
    TextAttr:=SEL;
    writeln(str);
    TextAttr:=NORM;
end;


Function Func(x: real):real;
begin
    Func:=2*x*x*x+2*x*x+(-2)*x+7;
end;

Function FFunc(x: real):real;
begin
    FFunc:=1/2*x*x*x*x+2/3*x*x*x+x*x+7*x;
end;
//show information
Procedure Information;
begin
    ClrScr;
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
        ch:= readkey; 
    until ch=#13;
    //readln;
end;

//enter limit of integration
Procedure Limit;
begin
    ClrScr;
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
        ch:= readkey; 
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
        ch:= readkey; 
    until ch=#13;
end;


Function Result:real;
var 
    r:real = 0;
    h:real;
begin
    ClrScr;
    if (a<>0) and (b<>0) then begin
        if steps <= 0 then begin
            WriteError('You did not set the number of steps! Enter <Enter> for continue');
        end
        else begin
            h:=(b-a)/steps;
            i:=a;
            while i+eps < b do begin
                if (i>x1+eps) then begin
                    r:= r+(h*(Func(i)+Func(i+h))/2);
                end;
                i:=i+h;
            end;
            Exit(r);
        end;
    end
    else
    begin
        WriteError('You have not entered the limits of integration! Enter <Enter> for continue');
    end;
    Exit(-1);
    // repeat
    //     ch:= readkey; 
    // until ch=#13;
end;

procedure ShowResult;
var r:real;
var h:real;
begin
    r:=Result;
    if r >= 0-eps then begin
        h:=(b-a)/steps;
        write('The area on the segment [',a:5:2,';',b:5:2,'] with a step ',h:5:2,' is equal to ');
        writeln(r:5:2);
        WriteSuccess('Enter <Enter> for continue.');
    end;
    repeat
        ch:= readkey; 
    until ch=#13;
end;


procedure AbsAcc;
var r,l:real;
begin
    ClrScr;
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
        ch:= readkey; 
    until ch=#13;
end;


procedure RelAcc;
var r,l:real;
begin
    ClrScr;
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
        ch:= readkey; 
    until ch=#13;
end;

Procedure MenuToScr;
var i:integer;
begin
    ClrScr;
    for i:=1 to N do 
    begin 
        GoToXY(x,y+i-1);
        write(menu[i]);
    end;
    writeln();
    writeln();
    writeln('[',c:5:2,';',d:5:2,'], number of steps: ',steps:5:2);
    TextAttr:=SEL;
    GoToXY(x,y+punkt-1);
    write(menu[punkt]);
    TextAttr:=NORM;
end;

begin
    menu[1]:='Information on the program';    
    menu[2]:='Enter limit of integration';   
    menu[3]:='Enter the number of steps';
    menu[4]:='Result';
    menu[5]:='Absolute accuracy';
    menu[6]:='Relative accuracy';
    menu[7]:='Exit';
    punkt:=1;     
    x:=1;     
    y:=1; 
    TextAttr:=NORM;
    MenuToScr;
    repeat 
    ch:=ReadKey;
    if ch=#0 then begin 
        ch:=ReadKey;
        case ch of 
        #80:
            if punkt<N then 
            begin 
                GoToXY(x,y+punkt-1); 
                write(menu[punkt]);
                punkt:=punkt+1;
                TextAttr:=SEl;
                GoToXY(x,y+punkt-1); 
                write(menu[punkt]);
                TextAttr:=NORM;
            end;
        #72:
            if punkt>1 then 
            begin 
                GoToXY(x,y+punkt-1); 
                write(menu[punkt]);
                punkt:=punkt-1;
                TextAttr:=SEl;
                GoToXY(x,y+punkt-1); 
                write(menu[punkt]);
                TextAttr:=NORM;
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
            7:ch:=#27;
            end;
            MenuToScr;
            end;
    until ch=#27;
    ClrScr;
end.
