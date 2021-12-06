program lab4;

uses math;

type
    TFunc=function(x:real):real; 
    TRange=array[0..1] of real;

const
    RangeT:TRange=(0.2,1.2);
    RangeS:TRange=(0.6,1.4);

var result1:array of array[0..1] of  real;
var resultS:array of array[0..1] of real;

function TrapezoidDerivarion(x:real):real;
begin
    Exit( -( Power(x*x+1,-3/2) - 3*x*x*Power(x*x+1,-5/2) ) );
end;

function SimpsonFunc(x:real):real;
begin
    Exit(cos(x)/(x+1));
end;

function FuncTrapezoid(x:real):real;
begin
    Exit(1/sqrt(x*x+1));
end;

procedure PrintResult1();
var i,j:integer;
begin
    write('i':4);
    write('xi':8);
    
    write('f(x)':8);
    writeln('k':4);
    for i:=0 to length(result1) do
    begin
        write(i:4);
        for j:=0 to length(result1[i])-1 do
        begin
            
            write(result1[i][j]:8:4);
        end;
        if(i=0) or (i=length(result1))then
        begin
            write('1/2':4);
        end
        else
        begin
            write('1':4);
        end;
        writeln();
    end;
    
end;
procedure PrintResult2();
var i,j:integer;
begin
    write('i':4);
    write('xi':8);
    
    write('f(x)':8);
    writeln;
    //writeln('k':4);
    for i:=0 to length(resultS) do
    begin
        write(i:4);
        for j:=0 to length(resultS[i])-1 do
        begin
            
            write(resultS[i][j]:10:6);
        end;
        // if(i=0) or (i=length(result1))then
        // begin
        //     write('1/2':4);
        // end
        // else
        // begin
        //     write('1':4);
        // end;
        writeln();
    end;
    
end;


procedure Trapezoids(Func:TFunc;Derivation:TFunc;range:TRange;eps:real);
var i:integer;
    a,b:real;
    n:integer;
    h:real;
    sum:real;
    result:real;
begin
    a:=range[0];
    b:=range[1];

    //n:=abs( round(Derivation(b)*Power(b-a,3)/(12*eps) ));
    //h:=(b-a)/n;
    h:=sqrt(eps);
    n:=round((b-a)/h);
    setlength(result1,n);
    writeln('Trapezoids: ');
    write('Range: ');writeln('[',a:5:4,',',b:5:4,']');
    write('e = ');writeln(eps:5:4);
    write('h = ');writeln(h:5:4);
    //writeln(n:10);
//     n = abs(round((b - a) ** 3 * derivation(a) / (12 * eps))) 
//     h = (b - a) / n 
    for i:=0 to n do
    begin
        result1[i][0]:=a+h*i;
        result1[i][1]:=func(a+h*i);
    end;
    PrintResult1();
    sum:=0;
    for i:=0 to n do
    begin
        if (i=0) or (i=n) then
        begin
            sum:=sum+1/2*result1[i][1];
        end
        else
        begin
            sum:=sum+result1[i][1];
        end;
    end;
    writeln();
    write('Sum: ');
    writeln(sum:7:4);
    writeln();
    result:=sum*h;
    write('Result: ');
    writeln(Result:7:4);
end;

function Simpson(Func:TFunc;n:integer;a,h:real):real;
var sum:real;
    i:integer;
begin

    for i:=0 to n do
        begin
            resultS[i][0]:=a+h*i;
            resultS[i][1]:=func(a+h*i);
        end;
        PrintResult2();
        sum:=0;
        for i:=0 to n do
        begin
            if (i=0) or (i=n) then
            begin
                sum:=sum+resultS[i][1];
            end
            else
            begin
                if( (i mod 2) = 0 ) then
                begin
                    sum:=sum+2*resultS[i][1];
                end
                else
                begin
                    sum:=sum+4*resultS[i][1];
                end;
            end;
        end;
        Exit(sum);
end;



procedure SimpsonRunge(Func:TFunc;range:TRange;eps:real);
var i:integer;
    h:real;
    n:integer;
    a,b:real;
    sum:real;
    r1:real;
    r2:real;
    d:integer;
begin
    a:=range[0];
    b:=range[1];
    h:=sqrt(eps);
    n:=round((b-a)/h);
    setlength(resultS,n);
    
    writeln('Simpson: ');
    
    
        write('Step: h');
        write('Range: ');writeln('[',a:5:4,',',b:5:4,']');
        write('e = ');writeln(eps:5:4);
        write('h = ');writeln(h:5:4);
        
        sum:=Simpson(Func,n,a,h);
        writeln();
        write('Sum: ');
        writeln(sum:7:6);
        writeln();
        r1:=sum*h/3;
        write('Result: ');
        writeln(r1:7:6);

        writeln();
        write('Step: h/2');
        write('Range: ');writeln('[',a:5:4,',',b:5:4,']');
        write('e = ');writeln(eps:5:4);
        write('h/2 = ');writeln(h/2:5:4);
        
        n:=round((b-a)/(h/2));
        setlength(resultS,n);
        sum:=Simpson(Func,n,a,h/2);
        writeln();
        write('Sum: ');
        writeln(sum:7:6);
        writeln();
        r2:=sum*((h/2)/3);
        write('Result: ');
        writeln(R2:7:6);

        writeln();
        write('Difference: ');
        writeln(abs(r1-r2):8:15);

        write('Result: ');
        writeln(R2:7:6);
end;



begin
    //Trapezoids(@FuncTrapezoid,@TrapezoidDerivarion,RangeT,0.0001);
    SimpsonRunge(@SimpsonFunc,RangeS,0.0001);

end.