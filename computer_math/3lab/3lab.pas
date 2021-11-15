program lab3;

uses math;

const
    k=6;
    k2=10;
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
    x1,x2:real;




procedure Init1;
begin
    x:=0.527;
    mx[1]:=0.43;
    mx[2]:=0.48;
    mx[3]:=0.55;
    mx[4]:=0.62;
    mx[5]:=0.70;
    mx[6]:=0.75;

    my[1]:=1.63597;
    my[2]:=1.73234;
    my[3]:=1.87686;
    my[4]:=2.03345;
    my[5]:=2.22846;
    my[6]:=2.83973;
end;

procedure init2;
begin
    x1:=1.217;
    x2:=1.253;

    mx2[1]:=1.215;
    mx2[2]:=1.220;
    mx2[3]:=1.225;
    mx2[4]:=1.230;
    mx2[5]:=1.235;
    mx2[6]:=1.240;
    mx2[7]:=1.245;
    mx2[8]:=1.250;
    mx2[9]:=1.255;
    mx2[10]:=1.260;

    my2[1]:=0.106044;
    my2[2]:=0.106491;
    my2[3]:=0.106935;
    my2[4]:=0.107377;
    my2[5]:=0.107818;
    my2[6]:=0.108257;
    my2[7]:=0.108696;
    my2[8]:=0.109134;
    my2[9]:=0.109571;
    my2[10]:=0.110008;

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



procedure writeTable();
var i,j:integer;
begin
    for i:=1 to k do 
    begin
        for j:=1 to k+2 do
        begin
            writeln(r[i,j]:15:6);
        end;
        writeln(' ');
        

        writeln();
    end;
end;

procedure writeTable2();
var i,j:integer;
begin
    for i:=1 to k2-1 do 
    begin
        for j:=1 to k2-1 do
        begin
            write(r2[i,j]:10:7);
        end;
        writeln(' ');
        

        writeln();
    end;


end;
procedure writeTableEl2();
var i:integer;
begin
    for i:=1 to k2-1 do
    begin
        writeln(el2[i]:8:7);
    end;
end;

begin
    // Init1();
    // methodLag();
    // writeTable();
    // writeln(s);
    // writeln(sd);
    // write('Resultat: ');
    // writeln((s*sd):10:6);

    //2
    init2();
    methodN();
    writeln(N1(x1):10:6);
    writeln(N2(x2):10:6);
    //writeTable2();
    // writeTableEl2();
end.