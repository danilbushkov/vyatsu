program lab3;
uses Crt;
const
    NORM=LightGray; 
    SEL=Green;  
    N=7;
var 
    menu:array[1..N] of string;
    punkt:integer;  
    ch:char; 
    x,y:integer;   
    a: real=0;
    b: real=0;
    res: real;
    abs_a: real;
    rel_a: real;
    step: real=0;
    f: boolean = False;

Function Equation(x: real):real;
begin
    Equation:=2*x*x*x+2*x*x+(-2)*x+7;
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
    repeat
        ch:= readkey; 
    until ch=#13;
    //readln;
end;

//enter limit of integration
Procedure Limit;
begin
    ClrScr;
    writeln('Enter the start of integration:');
    Readln(a);
    repeat
        writeln('Enter the end of integration:');
        Readln(b);
        if b <= a then begin
            writeln('The number must be greater than the beginning:');
        end
        else f := True;
    until f;
    Writeln('Done! Enter <Enter> for continue');
    repeat
        ch:= readkey; 
    until ch=#13;
end;

//enter step of integration
Procedure Step;
begin
    ClrScr;
    Writeln('Enter number of steps');
    repeat
        Readln(steps);
        if steps <= 0 then begin
            writeln('The number steps must be greater than 0! Try again.');
        end;
    until (steps > 0);
    Writeln('Done! Enter <Enter> for continue');
    repeat
        ch:= readkey; 
    until ch=#13;
end;


Function Result:real;
var 
    r:real;
begin
    ClrScr;
    if a<>0 and b<>0 then begin
        if steps <= 0 then begin
            writeln('You did not set the number of steps! Enter <Enter> for continue');
        end
        else begin
            while  then begin
                
            end;
        end;
    end
    else
    begin
        writeln('You have not entered the limits of integration! Enter <Enter> for continue');
    end;
    Result:=-1;
    // repeat
    //     ch:= readkey; 
    // until ch=#13;
end;

procedure AbsAcc;
begin
    ClrScr;

    repeat
        ch:= readkey; 
    until ch=#13;
end;


procedure RelAcc;
begin
    ClrScr;

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
            4:Result;
            5:AbsAcc;
            6:RelAcc;
            7:ch:=#27;
            end;
            MenuToScr;
            end;
    until ch=#27;
    ClrScr;
end.
