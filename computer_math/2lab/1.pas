program one;

uses math;

const
    count=3;
    e=0.0001;
type 

    TMatrix=array[1..count,1..count+1] of double;
    TVector=array[1..count] of double;
var 
    matrix:TMatrix;
    matrix2:TMatrix;
    m:TVector;
    result:TVector;
    result2:TVector;


procedure init();
begin
    matrix[1,1]:=1 ;matrix[1,2]:=-2 ;matrix[1,3]:=1 ;matrix[1,4]:=0;
    matrix[2,1]:=2 ;matrix[2,2]:=2 ;matrix[2,3]:=-1 ;matrix[2,4]:=3;
    matrix[3,1]:=4 ;matrix[3,2]:=-1 ;matrix[3,3]:=1 ;matrix[3,4]:=5;

    matrix2[1,1]:=0.0 ;matrix2[1,2]:=0.16 ;matrix2[1,3]:=-0.08 ;matrix2[1,4]:=1.2;
    matrix2[2,1]:=0.2 ;matrix2[2,2]:=0.0 ;matrix2[2,3]:=-0.424 ;matrix2[2,4]:=-1.736;
    matrix2[3,1]:=-0.1389 ;matrix2[3,2]:=-0.58889 ;matrix2[3,3]:=0.0 ;matrix2[3,4]:=-0.0667;
end;

procedure PrintResult(result:TVector);
var i:integer;
begin
    for i:=1 to count do
    begin
        write(result[i]:5:3);
        write(' ');
    end;
    writeln();
end;

procedure method1(var matrix:TMatrix);
var i,j,a,b:integer;
begin
    //прямой ход
    for i:=1 to count-1 do
    begin
        //вычисляем коэффициенты
        for j:=i+1 to count do
        begin
            m[j]:=-matrix[j,i]/matrix[i,i];
        end;
        //складываем
        for a:=i+1 to count do
        begin
            for b:=1 to count+1 do
            begin
                matrix[a,b]:=matrix[a,b]+m[a]*matrix[i,b];
            end;
        end;

    end;

    //обратный ход
    for i:=count downto 1 do
    begin
        result[i]:=matrix[i,count+1];
        for j:=i to count do
        begin
            if j<>i then
            begin
                result[i]:=result[i]-matrix[i,j]*result[j];
            end;
        end;
        result[i]:=result[i]/matrix[i,i];
    end;

end;


procedure method2(matrix:TMatrix);
var i,j:integer;
    M:double=0;
    tmpR:TVector;
    a:double;
begin
    //Начальное приближение - вектор свободных членов
    for i:=1 to count do
    begin
        result2[i]:=0;//matrix2[i,count+1];
    end;
    

    //метод итераций
    repeat
        tmpR:=result2;

        for i:=1 to count do
        begin
            result2[i]:=0;
        end;

        for i:=1 to count do
        begin
            for j:=1 to count do
            begin
                if(abs(matrix2[i,j])>0.000001) then
                begin
                    result2[i]:=result2[i]+matrix2[i,j]*tmpR[j];
                    
                end;
            end;
            if(abs(matrix2[i,count+1])>0.000001) then
            begin
                result2[i]:=result2[i]+matrix2[i,count+1];
            end;
            
            
        end;
        writeln();
        PrintResult(result2);
        M:=abs(result2[1]-tmpR[1]);
        
        for i:=2 to count do
        begin
            a:=abs(result2[i]-tmpR[i]);
            if(a>M) then
            begin
                M:=a;
            end;
        end;
        
    until (M<e);
end;

procedure PrintMatrix();
var i,j:integer;
begin
    for i:=1 to count do
    begin
        for j:=1 to count+1 do
        begin
            write(matrix[i,j]:8:3);
            write(' ');
        end;
        writeln();
    end;
end;



begin
    init();
    //method1(matrix);
    //PrintMatrix();
    //PrintResult(result);
    writeln();
    method2(matrix2);
    PrintResult(result2);
end.