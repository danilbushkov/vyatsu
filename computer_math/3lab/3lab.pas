program lab3;

uses math;

const
    k=6;
var mx:array[1..k] of real;
    my:array[1..k] of real;
    x:real;
    s:real=0;
    sd:real=0;
    r:array[1..k,1..k+2] of real;

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

begin
    Init1();
    methodLag();
    writeTable();
    writeln(s);
    writeln(sd);
    write('Resultat: ');
    writeln((s*sd):10:6);
end.