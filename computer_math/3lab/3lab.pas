program lab3;

uses math;

const
    k=6;
    k2=12;
    k3=10;
    step=0.005;
var mx:array[1..k] of real;
    my:array[1..k] of real;
    mx2:array[1..k2] of real;
    my2:array[1..k2] of real;
    x:real;
    s:real=0;
    sd:real=0;
    r:array[1..k,1..k+2] of real;
    r2:array[1..k2-1,1..k2-1] of real;
    el:array[1..k2-1] of real;
    ell:array[1..k2-1] of real;
    el2:array[1..k2-1] of real;
    el3:array[1..k2-1] of real;
    p:real;
    x1,x2,x3,x4:real;

    mx3,my3:array[1..k3] of real;
    a,b:real;
    res:real;


procedure Init1;
begin
    x:=0.616;
    mx[1]:=0.41;
    mx[2]:=0.46;
    mx[3]:=0.52;
    mx[4]:=0.60;
    mx[5]:=0.65;
    mx[6]:=0.72;

    my[1]:=2.57418;
    my[2]:=2.32513;
    my[3]:=2.09336;
    my[4]:=1.86203;
    my[5]:=1.74926;
    my[6]:=1.62098;
end;

procedure init2;
begin
    x1:=0.1817;
    x2:=0.2275;
    x3:=0.175;
    x4:=0.2375;

    mx2[1]:=0.180;
    mx2[2]:=0.185;
    mx2[3]:=0.190;
    mx2[4]:=0.195;
    mx2[5]:=0.200;
    mx2[6]:=0.205;
    mx2[7]:=0.210;
    mx2[8]:=0.215;
    mx2[9]:=0.220;
    mx2[10]:=0.225;
    mx2[11]:=0.230;
    mx2[12]:=0.235;

    my2[1]:=5.61543;
    my2[2]:=5.46698;
    my2[3]:=5.32634;
    my2[4]:=5.19304;
    my2[5]:=5.06649;
    my2[6]:=4.94619;
    my2[7]:=4.83170;
    my2[8]:=4.72261;
    my2[9]:=4.61855;
    my2[10]:=4.51912;
    my2[11]:=4.42422;
    my2[12]:=4.33337;

end;

procedure init3;
begin
    mx3[1]:=4.0;
    mx3[2]:=4.1;
    mx3[3]:=4.2;
    mx3[4]:=4.3;
    mx3[5]:=4.4;
    mx3[6]:=4.5;
    mx3[7]:=4.6;
    mx3[8]:=4.7;
    mx3[9]:=4.8;
    mx3[10]:=4.9;

    my3[1]:=128;
    my3[2]:=147;
    my3[3]:=169;
    my3[4]:=194;
    my3[5]:=223;
    my3[6]:=256;
    my3[7]:=294;
    my3[8]:=338;
    my3[9]:=388;
    my3[10]:=446;
end;


procedure methodLag();
var i,j:integer;
begin
    //Разность х
    for i:=1 to k do
    begin
        for j:=1 to k do 
        begin
            if(j<>i) then
            begin
                r[i,j]:=mx[i]-mx[j];
            end;
        end;
    end;
    //Диагональ
    for i:=1 to k do
    begin
        r[i,i]:=x-mx[i];
    end;

    //произведение элементов строк
    for i:=1 to k do
    begin
        r[i,7]:=r[i,1];
        for j:=2 to k do
        begin
            r[i,7]:=r[i,7]*r[i,j];
        end;
    end;
    //Произведение диагонали
    sd:=r[1,1];
    for i:=2 to k do
    begin
        sd:=sd*r[i,i];
    end;

    for i:=1 to k do
    begin
        r[i,8]:=my[i]/r[i,7];
        s:=s+r[i,8];
    end;
end;

function factorial(n:integer):longint;
var i:integer;
    f:longint=1;
begin
    for i:=2 to n do
        f := f * i;
    Exit(f);
end;

function FindQ(x:real):real;
begin
    Exit( (x-mx2[1])/step );
end;

function FindQEnd(x:real):real;
begin
    Exit( (x-mx2[k2])/step );
end;

procedure FindEl(q:real);//(q-q0)...(q-n+1)
var i,j:integer;
begin
    for i:=1 to k2-1 do
    begin
        el[i]:=q;
        for j:=2 to i do
        begin
            el[i]:=el[i]*(q-j+1);
            
        end;
        
    end;
end;

procedure FindEll(q:real);//(q-q0)...(q-n+1)
var i,j:integer;
begin
    for i:=1 to k2-1 do
    begin
        ell[i]:=q;
        for j:=2 to i do
        begin
            ell[i]:=ell[i]*(q+j-1);
            
        end;
        
    end;
end;

procedure FindEl2();//(q-q0)...(q-n+1)
var i,j:integer;
begin
    //j:=k2-1;
    for i:=1 to k2-1 do
    begin
        
        el2[i]:=r2[1,i]*el[i]/factorial(i);
        //writeln(r2[i,i]:10:7);

        //j:=j-1;
    end;
end;

procedure FindEl3();//(q-q0)...(q-n+1)
var i,j:integer;
begin
    j:=k2-1;
    for i:=1 to k2-1 do
    begin
        
        el3[i]:=r2[j,i]*ell[i]/factorial(i);
        //writeln(r2[i,i]:10:7);

        j:=j-1;
    end;
end;

function N1(x:real):real;
var Result:real;
 i:integer;
 q:real;
begin
    q:=FindQ(x);
    FindEl(q);
    FindEl2();
    Result:=my2[1];
    for i:=1 to k2-1 do
    begin
        Result:=Result+el2[i];
    end;
    Exit(Result);
end;

function N2(x:real):real;
var Result:real;
 i:integer;
 q:real;
begin
    q:=FindQEnd(x);
    FindEll(q);
    FindEl3();
    Result:=my2[k2];
    for i:=1 to k2-1 do
    begin
        Result:=Result+el3[i];
    end;
    Exit(Result);
end;



procedure methodN();
var i,j:integer;

begin
    for i:=1 to k2-1 do
    begin
        r2[i,1]:=my2[i+1]-my2[i];
    end;

    for i:=2 to k2-1 do
    begin
        for j:=1 to k2-i do
        begin
            r2[j][i]:=r2[j+1][i-1]-r2[j][i-1];
        end;

    end;
    
end;


function findB():real;
var i:integer;
    sumxlny:real=0;
    sumx:real=0;
    sumlny:real=0;
    sumx2:real=0;
    b:real;
begin

    for i:=1 to k3 do
    begin
        sumxlny:=sumxlny+mx3[i]*ln(my3[i]);
        sumx:=sumx+mx3[i];
        sumlny:=sumlny+ln(my3[i]);
        sumx2:=sumx2+mx3[i]*mx3[i];
    end;

    b:=exp( (k3*sumxlny-sumx*sumlny)/(k3*sumx2-sumx*sumx) );
    Exit(b);
end;

function findA(b:real):real;
var i:integer;
    sumx:real=0;
    sumlny:real=0;
    a:real;
begin

    for i:=1 to k3 do
    begin
        sumx:=sumx+mx3[i];
        sumlny:=sumlny+ln(my3[i]);
    end;

    a:=exp( 1/k3*sumlny-(ln(b)/k3)*sumx );
    Exit(a);
end;

function Pokaz(a,b,x:real):real;
begin
    Exit( a*Power(b,x) );
end;

function Lin(a,b,x:real):real;
begin
    Exit( exp(ln(a)+ln(b)*x) );
end;

// function KK(a,b:real):real;
// var i:integer;
//     yt:real=0;
//     sum1:real=0;
//     sum2:real=0;
//     r:real;
// begin
//     for i:=1 to k3 do
//     begin
//         yt:=yt+my3[i];
        
//     end;
//     yt:=yt/k3;
//     for i:=1 to k3 do
//     begin
//         sum1:=power( (my3[i]-Lin(a,b,mx3[i]) ),2);
//         sum2:=power( (my3[i]-yt ),2);
//     end;

//     r:=sqrt(1-sum1/sum2);
//     Exit(r);
// end;

//function app

procedure writeTask1();
var i,j:integer;
begin
    write('xi':10);writeln('yi':10);
    for i:=1 to k do
    begin
        write(mx[i]:10:6); writeln(my[i]:10:6);
    end;
    writeln();
end;

procedure writeTask2();
var i,j:integer;
begin
    write('xi':10);writeln('yi':10);
    for i:=1 to k2 do
    begin
        write(mx2[i]:10:6); writeln(my2[i]:10:6);
    end;
    writeln();
end;

procedure writeTask3();
var i,j:integer;
begin
    write('xi':10);writeln('yi':10);
    for i:=1 to k3 do
    begin
        write(mx3[i]:10:3); writeln(my3[i]:10:3);
    end;
    writeln();
end;


procedure writeTable();
var i,j:integer;
begin
    for i:=1 to k do 
    begin
        for j:=1 to k do
        begin
            write(r[i,j]:10:6);
        end;
        writeln(' ');
        

       // writeln();
    end;
    writeln();
    write('D, 10^-6':10); writeln('Yi/Di':10);
    for i:=1 to k do
    begin
        write((r[i,k+1]*1000000):10:6);writeln(r[i,K+2]:17:6);
    end;
    writeln();
    write('The product of the diagonal(10^-6): '); writeln((sd*1000000):10:6);
    write('The amount Yi/Di: ');writeln((s):10:6);
end;

procedure writeTable2();
var i,j,l:integer;
    s:string;
begin
    l:=0;
    write('Y':10);
    for i:=1 to k2-1 do
    begin
        str(i,s);
        write(('d'+s+'Y'):10);
    end;
    writeln();
    for i:=1 to k2 do 
    begin
        
        
            write(my2[i]:10:6);
            
         
         
        for j:=1 to k2-1 do
        begin
            if(i=0) then
            begin
               write(my2[i]:10:6); 
            end;
            if(j<k2-l) then
            begin
                write(r2[i,j]:10:6);
            end
            else
            begin
                write('':10);
            end;
        end;
        //writeln(' ');
        inc(l);

        writeln();
    end;
    

end;
procedure writeTableEl2();
var i:integer;
begin
    writeln('Members of the polynomial: ');
    for i:=1 to k2-1 do
    begin
        write(i);write(':');writeln(el2[i]:8:6);
    end;
end;
procedure writeTableEl3();
var i:integer;
begin
    writeln('Members of the polynomial: ');
    for i:=1 to k2-1 do
    begin
        write(i);write(':');writeln(el3[i]:8:6);
    end;
end;

procedure writeTable3();
var sumxi,sumx2i,sumyi,sumyixi,sumYiT,sumD,sumD2,d,g:real;
 i:integer;
begin   
    sumxi:=0;
    sumx2i:=0;
    sumyi:=0;
    sumyixi:=0;
    sumYiT:=0;
    sumD:=0;
    sumD2:=0;
    write('Xi':12);
        write('Xi^2':12);
        write('Yi':12);
        write('Yi*Xi':12);
        write('Yi*T':12);
        write('Del':12);
        write('Del^2':12);
        writeln();
    for i:=1 to k3 do
    begin
        write(mx3[i]:12:6);
        write((mx3[i]*mx3[i]):12:6);
        write(my3[i]:12:6);
        write((my3[i]*mx3[i]):12:6);
        write(Lin(a,b,mx3[i]):12:6);
        d:=my3[i]-Lin(a,b,mx3[i]);
        write(d:12:6);
        write(d*d:12:6);

        sumxi:=sumxi+mx3[i];
        sumx2i:=sumx2i+mx3[i]*mx3[i];
        sumyi:=sumyi+my3[i];
        sumyixi:=sumyixi+my3[i]*mx3[i];
        sumYiT:=sumYiT+Lin(a,b,mx3[i]);
        sumD:=sumD+d;
        sumD2:=sumD2+d*d;
        writeln();
    end;
    writeln('------------');
     write(sumxi:12:6);
        write(sumx2i:12:6);
        write(sumyi:12:6);
        write(sumyixi:12:6);
        write(sumYiT:12:6);
        write(sumD:12:6);
        write(sumD2:12:6);
        writeln();

        g:=sqrt(sumD2)/k3;
        write('standard deviation: ');
        writeln(g:10:6);
end;

// procedure writeTableEl();
// var i:integer;
// begin
//     writeln('The first interpolation formula:');
//     writeln('q');
//     for i:=1 to k2 do
//     begin
//         write(i); write(':');
//         write('x-'); write(mx2[i]:7:6);write('=');
//         write(el[i]:7:6);writeln();
//     end;
// end;
// procedure writeTableEl();
// var i:integer;
// begin
//     writeln('The first interpolation formula:');
//     writeln('q');
//     for i:=1 to k2 do
//     begin
//         write(i); write(':');
//         write('x-'); write(mx2[i]:7:6);write('=');
//         write(el[i]:7:6);writeln();
//     end;
// end;

begin
    Init1();
    methodLag();
    writeln('Lagrange method:');
    writeln();
    write('X = '); writeln(x:10:6);
    writeln();
    writeTask1();
     
     
     writeTable();
     //writeln(s);
     //writeln(sd);
     write('Result: L(0.616) = ');
     writeln((s*sd):10:6);
    writeln();
    //2
    writeln('-----------------------------------');
    writeln('Newton ''s Interpolation:');
    init2();
    methodN();
    write('X1 = '); writeln(x1:10:6);
     write('X2 = '); writeln(x2:10:6);
      write('X3 = '); writeln(x3:10:6);
       write('X4 = '); writeln(x4:10:6);
       
    writeTask2();
    writeln('Step=0.005');
    // writeln(N1(x1):10:6);
    // writeln(N2(x2):10:6);
    writeTable2();
    // writeTableEl2();
    Writeln();

    writeln('The first interpolation formula:');
    write('x1=');
    writeln(0.1817:10:6);
    write('q=');writeln(FindQ(x1):10:6);
    res:=N1(x1);
    writeTableEl2();
    write('y0=');writeln(my2[1]:10:6);
    writeln();
    write('P(0.1817) = ');
    writeln(res:10:6);
    writeln();

    writeln('The second interpolation formula:');
    write('x2=');
    writeln(0.2275:10:6);
    write('q=');writeln(FindQEnd(x2):10:6);
    res:=N2(x2);
    writeTableEl3();
    write('yn=');writeln(my2[k2]:10:6);
    writeln();
    write('P(0.2275) = ');
    writeln(res:10:6);
    writeln();

    writeln('The first interpolation formula:');
    write('x3=');
    writeln(0.175:10:6);
    write('q=');writeln(FindQ(x3):10:6);
    res:=N1(x3);
    writeTableEl2();
    write('y0=');writeln(my2[1]:10:6);
    writeln();
    write('P(0.175) = ');
    writeln(res:10:6);
    writeln();

    writeln('The second interpolation formula:');
    write('x4=');
    writeln(0.2375:10:6);
    write('q=');writeln(FindQEnd(x4):10:6);
    res:=N2(x4);
    writeTableEl3();
    write('yn=');writeln(my2[k2]:10:6);
    writeln();
    write('P(0.2375) = ');
    writeln(res:10:6);
    writeln();

    writeln('------------------');
    writeln('Least Squares:');
    
    
     init3;
     writeTask3();
     writeln('Type of empirical dependence: Exponential regression'); 
     b:=findB();
     a:=findA(b);
     write('a=');writeln(a:8:6);
     write('b=');writeln(b:8:6);
     write('The equation: y=');
     write(a:8:6); write('+');write(b:8:6);writeln('^x');
    writeln('lny=Y, lna=A, lnb=B');
    write('linear view: Y=');write(ln(a):8:6); write('+');write(ln(b):8:6);writeln('x');
     writeTable3();
    // writeln(a:10:6);
   // writeln(KK(a,b):10:6);
end.