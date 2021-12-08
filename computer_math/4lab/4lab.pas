program lab4;

uses math;//,crt;

type
    TFunc=function(x:real):real; 
    TDUFunc=function(x,y:real):real;
    TRange=array[0..1] of real;
    TGaussRow=array of real;
    TGaussArray=array of TGaussRow;

const
    RangeT:TRange=(0.2,1.2);
    RangeS:TRange=(0.6,1.4);
    RangeG:TRange=(2.2,3.4);
    RangeEC:TRange=(0,1);

var result1:array of array[0..1] of  real;
    resultS:array of array[0..2] of real;
    pointsGauss1:TGaussArray;
    pointsGauss2:TGaussArray;
    ch:integer;

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

function FuncGauss(x:real):real;
begin
    Exit( x*x/sqrt(x+1) );
end;

function FuncEulerCauchy(x,y:real):real;
begin
    Exit(2*x*x+3*y);
end;

function FuncEulerCauchy(x:real):real;
begin
    Exit(-0.148148 + 0.348148*exp(3*x) - 0.444444*x - 0.666667*x*x);
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
    //writeln;
    writeln('k':4);
    for i:=0 to length(resultS)-1 do
    begin
        
            write(resultS[i][0]:10:6);
            write(resultS[i][1]:10:6);
            write(resultS[i][2]:4:0);
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
    setlength(result1,n+1);
    writeln('Trapezoids: ');
    writeln('f(x)=1/sqrt(x^2+1)  ');
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
        
        sum:=0;
        for i:=0 to n do
        begin
            if (i=0) or (i=n) then
            begin
                sum:=sum+resultS[i][1];
                resultS[i][2]:=1;
            end
            else
            begin
                if( (i mod 2) = 0 ) then
                begin
                    sum:=sum+2*resultS[i][1];
                    resultS[i][2]:=2;
                end
                else
                begin
                    sum:=sum+4*resultS[i][1];
                    resultS[i][2]:=4;
                end;
            end;
        end;
        PrintResult2();
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
    setlength(resultS,n+1);
    
    writeln('Simpson: ');
        writeln('f(x)=cos(x)/(x+1)');
    
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
        setlength(resultS,n+1);
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

procedure InitGauss();
begin
    pointsGauss1:=TGaussArray.Create(
        TGaussRow.Create(-0.86114,-0.33998,0.33998,0.86114),
        TGaussRow.Create(0.34785,0.65215,0.65215,0.34785)
    );

    pointsGauss2:=TGaussArray.Create(
        TGaussRow.Create(-0.949107912,
                        -0.741531186,
                        -0.405845151,
                        0,
                        0.405845151,
                        0.741531186,
                        0.949107912),
        TGaussRow.Create(
            0.129484966,
            0.279705391,
            0.381830051,
            0.417959184,
            0.381830051,
            0.279705391,
            0.129484966)
    );
end;

procedure PrintTableG(points:TGaussArray;table:TGaussArray);
var i,j:integer;
begin
    write('i':4);
    write('xi':13);
    write('Ai':13);
    write('Argi':13);
    write('f(argi)':13);
    writeln('Ai*f(argi)':13);
    for i:=0 to length(points[0])-1 do 
    begin
        write(i:4);
        write(points[0][i]:13:9);
        write(points[1][i]:13:9);
        write(table[0][i]:13:9);
        write(table[1][i]:13:9);
        write(table[2][i]:13:9);
        writeln();
    end;
    writeln();
end;

procedure PrintNodes(points:TGaussArray);
var i:integer;
begin
    for i:=0 to length(points[0])-1 do
    begin
        write('x',i+1,'=',points[0][i]:13:9,'   ');
        writeln('A',i+1,'=',points[1][i]:13:9);
    end;
end;

function Gauss(Func:TFunc;a,b:real;points:TGaussArray):real;
var i:integer;
    sum:real;
    arg:real;
    fx:real;
    afx:real;
    m:real;
    result:real;
    table:TGaussArray;
begin
    sum:=0;
    setlength(table,3);
    for i:=0 to 2 do
    begin
        setlength(table[i],length(points[0]));
    end;
    for i:=0 to length(points[0])-1 do
    begin
        arg:=( (b-a)/2 )*points[0][i]+(a+b)/2;
        table[0][i]:=arg;
        fx:=Func(arg);
        table[1][i]:=fx;
        afx:=fx*points[1][i];
        table[2][i]:=afx;
        sum:=sum+afx;
        
    end;
    PrintTableG(points,table);
    writeln('sum: ',sum:10:9);

    m:=(b-a)/2;
    writeln('(b-a)/2=',m:10:9);

    result:=m*sum;
    writeln;
    Writeln('Result: ',result:10:9);
    Exit(result);
end;


procedure GaussTask(Func:TFunc;range:TRange);
var a,b:real;
    r1,r2:real;
begin
    InitGauss();
    a:=range[0];
    b:=range[1];
    writeln('Gauss:');
    writeln('f(x)= x^2/sqrt(x+1)');
    writeln();
    writeln('4 nodes:');
    PrintNodes(pointsGauss1);
    writeln();

    writeln('7 nodes:');
    PrintNodes(pointsGauss2);
    writeln();


    writeln();
    write('Range: ');writeln('[',a:5:4,',',b:5:4,']');
    writeln('For 4 nodes');
    writeln('n=',length(pointsGauss1[0]));
    writeln;
    
    r1:=Gauss(Func,a,b,pointsGauss1);


    writeln;
    writeln('For 7 nodes');
    writeln('n=',length(pointsGauss2[0]));
    writeln;
    
    r2:=Gauss(Func,a,b,pointsGauss2);
    writeln();
    Writeln('Difference: ',abs(r2-r1):11:9);

end;

procedure printTableEC(table:TGaussArray);
const d=12;
var i,j:integer;
    
begin
    write('i':4);
    write('xi':d);
    write('yi':d);
    write('f(xi,yi)':d);
    write('xi+h':d);
    write('yi+hfi':d);
    write('f(+h,+hfi)':d);
    write('dyi':d);
    write('eyi':d);
    writeln('abs(eyi-yi)':d );
    for i:=0 to length(table) do 
    begin
        write(i:4);
        for j:=0 to 8 do begin
            write(table[i][j]:d:5);
        end;
        writeln();
    end;
    writeln();
end;


procedure EulerCauchy(f:TDUFunc;a,b:real;h:real;y0:real);
var i:integer;
    n:integer;
    table:TGaussArray;
    y,x:real;dy:real;fh,fi:real;ey:real;
    eps:real;xh:real;fkh:real;
    yhf:real;
begin
    
    n:=round((b-a)/h);
    setlength(table,n);
    y:=y0;
    dy:=0;
    for i:=0 to n do
    begin
        setlength(table[i],9);
    end;

    for i:=0 to n-1 do
    begin
        y:=y+dy;
        x:=i*h;
        table[i][0]:=x;
        
        table[i][1]:=y;
        fi:=f(x,y);
        table[i][2]:=fi;

        xh:=x+h;
        table[i][3]:=xh;

        yhf:=y+h*fi;
        table[i][4]:=yhf;

        fh:=f(xh,yhf);
        table[i][5]:=fh;

        dy:=(h/2)*(fi+fh);
        table[i][6]:=dy;

        table[i][7]:=FuncEulerCauchy(x);
        table[i][8]:=abs(table[i][7]-y);
    end;
    y:=y+dy;
    x:=x+h;
    table[n][0]:=x;
        
    table[n][1]:=y;
    table[n][7]:=FuncEulerCauchy(x);
    table[n][8]:=abs(table[n][7]-y);


    printTableEC(table);
    writeln();
end;

procedure EulerCauchyTask(f:TDUFunc;range:TRange;h:real);
var n:integer;
    a,b:real;
begin
    a:=range[0];
    b:=range[1];
    writeln('The Euler-Cauchy method of the 2nd order of accuracy:');
    writeln(' y''=2*x^2+3*y');
    writeln('a=1/2;  y(0)=0,2; h=0,1; 0<=x<=1');
    writeln('y(x)=-0.148148 + 0.348148*e^(3 x) - 0.444444 x - 0.666667 x^2');
    writeln();
    writeln('Step: h=0.1:');
    
    EulerCauchy(f,a,b,h,0.2);

    writeln('Step: h/2=',(h/2):4:2,':');

    EulerCauchy(f,a,b,h/2,0.2);


end;


begin

      repeat
        
    //      ch:=readkey();
    //      ClrScr();
          writeln('1 - Trapezoids');    
          writeln('2 - Simpson');
          writeln('3 - Gauss');
          writeln('4 - The Euler-Cauchy method of the 2nd order of accuracy');
          writeln('5 - Exit');
          Write('Task: ');readln(ch);

          if(ch<>5) then writeln('---------------------------------------------');

         if(ch=1)then
         begin
             Trapezoids(@FuncTrapezoid,@TrapezoidDerivarion,RangeT,0.0001);
         end;
         if(ch=2)then
         begin
             SimpsonRunge(@SimpsonFunc,RangeS,0.0001);
    
         end;
         if(ch=3)then
         begin
             GaussTask(@FuncGauss,RangeG);
         end;
         if(ch=4)then
         begin
             EulerCauchyTask(@FuncEulerCauchy,RangeEC,0.1);
         end;
         if(ch<>5) then writeln('---------------------------------------------');

        if(ch<>5) then
        begin
            writeln('Press Enter');
            readln();
        end;

      until (ch=5);

    //Trapezoids(@FuncTrapezoid,@TrapezoidDerivarion,RangeT,0.0001);
    //SimpsonRunge(@SimpsonFunc,RangeS,0.0001);
    //GaussTask(@FuncGauss,RangeG);
    //EulerCauchyTask(@FuncEulerCauchy,RangeEC,0.1);
    

end.