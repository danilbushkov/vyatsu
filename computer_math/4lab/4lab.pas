program lab4;

uses math;

type
    TFunc=function(x:real):real; 
    TRange=array[0..1] of real;

const
    RangeT:TRange=(0.2,1.2);

var result1:array of array[0..1] of  real;

function TrapezoidDerivarion(x:real):real;
begin
    Exit( -( Power(x*x+1,-3/2) - 3*x*x*Power(x*x+1,-5/2) ) );
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





begin
    Trapezoids(@FuncTrapezoid,@TrapezoidDerivarion,RangeT,0.0001);
    

end.