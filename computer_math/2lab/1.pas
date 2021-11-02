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
    umatrix:TMatrix;
    matrix4:TMatrix;
    m:TVector;
    result:TVector;
    result2:TVector;
    result3:TVector;
    result4:TVector;
    

function A13(x,y:double):double;
begin
    Exit( x-exp(y-1.5)+4.8 )
end;
function A23(x,y:double):double;
begin
    Exit( y - sin(x) )
end;

function A12(x,y:double):double;
begin
    Exit( -exp(y-1.5) )
end;
function A21(x,y:double):double;
begin
    Exit( -cos(x) )
end;
function A11(x,y:double):double;
begin
    Exit( 1 )
end;
function A22(x,y:double):double;
begin
    Exit( 1 )
end;



procedure init();
var i,j:integer;
begin
    matrix[1,1]:=1 ;matrix[1,2]:=-2 ;matrix[1,3]:=1 ;matrix[1,4]:=0;
    matrix[2,1]:=2 ;matrix[2,2]:=2 ;matrix[2,3]:=-1 ;matrix[2,4]:=3;
    matrix[3,1]:=4 ;matrix[3,2]:=-1 ;matrix[3,3]:=1 ;matrix[3,4]:=5;

    matrix2[1,1]:=0.0 ;matrix2[1,2]:=0.16 ;matrix2[1,3]:=-0.08 ;matrix2[1,4]:=1.2;
    matrix2[2,1]:=0.2 ;matrix2[2,2]:=0.0 ;matrix2[2,3]:=-0.424 ;matrix2[2,4]:=-1.736;
    matrix2[3,1]:=-0.1389 ;matrix2[3,2]:=-0.58889 ;matrix2[3,3]:=0.0 ;matrix2[3,4]:=-0.0667;

    //единичная матрица
    for i:=1 to length(umatrix) do
    begin
        for j:=1 to length(umatrix) do
        begin
            if i=j then
            begin
                umatrix[i,j]:=1;
            end
            else
            begin
                umatrix[i,j]:=0;
            end;
        end;
    end;
end;

procedure PrintResult(result:TVector);
var i:integer;
begin
    for i:=1 to length(result) do
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

//метод обратной матрицы
procedure method3(matrix: TMatrix; umatrix:TMatrix;var result:TVector; len:integer);
var t:double;
    i,j,k:integer;
begin
    for k:=1 to len do
    begin
        t:=matrix[k,k];

        for j:=1 to len do
        begin
               matrix[k,j]:= matrix[k,j]/t;
               umatrix[k,j]:= umatrix[k,j]/t;
        end;

        for i:=k+1 to len do
        begin
            t:=matrix[i,k];
            for j:=1 to len do
            begin
                matrix[i,j]:=matrix[i,j] - matrix[k,j]*t;
                umatrix[i,j]:=umatrix[i,j] - umatrix[k,j]*t;
            end;
        end;

    end;

    for k:=len downto 2 do
    begin
        for i:=k-1 downto 1 do
        begin
            t:=matrix[i,k];
            for j:=1 to len do
            begin
                matrix[i,j]:=matrix[i,j]-matrix[k,j]*t;
                umatrix[i,j]:=umatrix[i,j]-umatrix[k,j]*t;
            end;
        end;
    end;

    for i:=1 to len do
    begin
        result[i]:=0;
        for j:=1 to len do
        begin
            result[i]:=result[i]+umatrix[i,j]*matrix[j,len+1]
        end;
    end;

end;


procedure method4(var v:TVector);
var matrix:TMatrix;
    x,y:double;
begin
    x:=0;
    y:=0;
    repeat
        matrix[1,1]:=A11(x,y); matrix[1,2]:=A12(x,y); matrix[1,3]:=-A13(x,y);
        matrix[2,1]:=A21(x,y); matrix[2,2]:=A22(x,y); matrix[2,3]:=-A23(x,y);
        method3(matrix,umatrix,v,2);
        x:=x+v[1];
        y:=y+v[2];
    until max(v[1]*v[1],v[2]*v[2]) < 0.001 ;
    v[1]:=x;
    v[2]:=y;
end;

procedure PrintMatrix(matrix:TMatrix);
var i,j:integer;
begin
    for i:=1 to count do
    begin
        for j:=1 to length(matrix)+1 do
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
    //method3(matrix,umatrix,result3,3);
    method4(result4);
    PrintResult(result4);
end.