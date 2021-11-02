program one;

uses math;

const
    count=4;
    e=0.0001;
type 

    TMatrix=array[1..count,1..count+1] of double;
    TVector=array[1..count] of double;
    
var 
    matrix1:TMatrix;
    matrix2:TMatrix;
    matrix3:TMatrix;
    matrix4:TMatrix;


    umatrix:TMatrix;
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
    matrix1[1,1]:=-1;  matrix1[1,2]:=0.13  ;matrix1[1,3]:=-2 ;matrix1[1,4]:=-0.14;matrix1[1,5]:=0.15;
    matrix1[2,1]:=0.75;matrix1[2,2]:=0.18  ;matrix1[2,3]:=-0.21 ;matrix1[2,4]:=-0.77;matrix1[2,5]:=0.11;
    matrix1[3,1]:=0.28;matrix1[3,2]:=-0.17 ;matrix1[3,3]:=0.39 ;matrix1[3,4]:=0.48;matrix1[3,5]:=0.12;
    matrix1[4,1]:=1;   matrix1[4,2]:=3.14 ;matrix1[4,3]:=-0.21 ;matrix1[4,4]:=-1;matrix1[4,5]:=-0.11;

    matrix2[1,1]:=0.14 ;matrix2[1,2]:=0.23 ;matrix2[1,3]:=0.18 ;matrix2[1,4]:=0.17;matrix2[1,5]:=-1.42;
    matrix2[2,1]:=0.12 ;matrix2[2,2]:=-0.14 ;matrix2[2,3]:=0.08 ;matrix2[2,4]:=0.09;matrix2[2,5]:=-0.83;
    matrix2[3,1]:=0.16 ;matrix2[3,2]:=0.24 ;matrix2[3,3]:=0 ;   matrix2[3,4]:=-0.35;matrix2[3,5]:=1.21;
    matrix2[4,1]:=0.23 ;matrix2[4,2]:=-0.08 ;matrix2[4,3]:=0.55 ;matrix2[4,4]:=0.25;matrix2[4,5]:=0.65;


    matrix3[1,1]:=1 ;matrix3[1,2]:=-2 ;matrix3[1,3]:=1 ;matrix3[1,4]:=0;matrix3[1,5]:=0;
    matrix3[2,1]:=2 ;matrix3[2,2]:=2 ;matrix3[2,3]:=-1 ;matrix3[2,4]:=3;matrix3[2,5]:=3;
    matrix3[3,1]:=4 ;matrix3[3,2]:=-1 ;matrix3[3,3]:=1 ;matrix3[3,4]:=5;matrix3[3,5]:=5;
    matrix3[3,1]:=4 ;matrix3[3,2]:=-1 ;matrix3[3,3]:=1 ;matrix3[3,4]:=5;matrix3[3,5]:=5;

    matrix4[1,1]:=1 ;matrix4[1,2]:=-2 ;matrix4[1,3]:=1 ;matrix4[1,4]:=0;matrix4[1,5]:=0;
    matrix4[2,1]:=2 ;matrix4[2,2]:=2 ;matrix4[2,3]:=-1 ;matrix4[2,4]:=3;matrix4[2,5]:=3;
    matrix4[3,1]:=4 ;matrix4[3,2]:=-1 ;matrix4[3,3]:=1 ;matrix4[3,4]:=5;matrix4[3,5]:=5;
    matrix4[3,1]:=4 ;matrix4[3,2]:=-1 ;matrix4[3,3]:=1 ;matrix4[3,4]:=5;matrix4[3,5]:=5;
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

procedure printTask1(m:TMatrix;len:integer);
begin

    writeln('The Gauss method:');
    writeln('-1,00*x1+0,13*x2-2,00*x3-0,14*x4=0,15');
    writeln(' 0,75*x1+0,18*x2-0,21*x3-0,77*x4=0,11');
    writeln(' 0,28*x1-0,17*x2+0,39*x3+0,48*x4=0,12');
    writeln(' 1,00*x1+3,14*x2-0,21*x3-1,00*x4=-0,11');
    writeln();
    
    write('x1':8);
    write('x2':10);
    write('x3':10);
    write('x4':10);
    write('bs':10);
    write('sum':10);

    writeln();

end;

procedure printTask2(m:TMatrix;len:integer);
begin

    writeln('Simple iteration method:');
    writeln('x1=0,14*x1+0,23*x2+0,18*x3+0,17*x4-1,42 ');
    writeln('x2=0,12*x1-0,14*x2+0,08*x3+0,09*x4-0,83');
    writeln('x3=0,16*x1+0,24*x2-0,35*x4+1,21');
    writeln('x4=0,23*x1-0,08*x2+0,55*x3+0,25*x4+0,65');
    writeln('e=0.0001');

   
    writeln();
end;


procedure PrintResult(result:TVector; len,t:integer);
var i:integer;
begin
    for i:=1 to len do
    begin
        write(result[i]:5:t);
        write(' ');
    end;
    writeln();
end;

procedure printTable(matrix:TMatrix; len,s:integer);
var i,j:integer;
sum,b:double;
begin
    sum:=0;
    for i:=s to count do
    begin
        for j:=1 to length(matrix)+1 do
        begin
            if abs(matrix[i,j])>0.000001 then
            begin
                sum:=sum+matrix[i,j];
                write(matrix[i,j]:9:3);
                write(' ');
            end
            else
            begin
                write(' ':10);
            end;
        end;
        write(sum:8:3);
        writeln();
    end;
    sum:=0;
    
    if(s<>length(matrix)) then
    begin
        writeln('                           --------------------');
        for i:=1 to length(matrix)+1 do
        begin
            if(abs(matrix[s,i])>0.000001) then
            begin
                b:=matrix[s,i]/matrix[s,s];
                write(b:10:3);
                sum:=sum+b;
            end
            else
            begin
                write(' ':10);
            end;
        end;
        write(sum:9:3);
    end;
    writeln;
    


end;


procedure method1(var matrix:TMatrix; len: integer);
var i,j,a,b:integer;
begin
    //прямой ход
    for i:=1 to len-1 do
    begin
        printTable(matrix,4,i);
        writeln();
        //вычисляем коэффициенты
        for j:=i+1 to len do
        begin
            m[j]:=-matrix[j,i]/matrix[i,i];
        end;
        //складываем
        for a:=i+1 to len do
        begin
            for b:=1 to len+1 do
            begin
                matrix[a,b]:=matrix[a,b]+m[a]*matrix[i,b];
                
            end;
            
        end;

    end;
    printTable(matrix,4,4);
    //обратный ход
    for i:=len downto 1 do
    begin
        result[i]:=matrix[i,len+1];
        for j:=i to len do
        begin
            if j<>i then
            begin
                result[i]:=result[i]-matrix[i,j]*result[j];
            end;
        end;
        result[i]:=result[i]/matrix[i,i];
    end;

end;


procedure method2(matrix:TMatrix;len:integer);
var i,j,n:integer;
    M:double=0;
    tmpR:TVector;
    a:double;
    s,st:double;
begin
    //Начальное приближение - вектор свободных членов
    for i:=1 to len do
    begin
        result[i]:=matrix[i,count+1];
    end;
    //норма 1
    s:=0;
    for i:=1 to len do
    begin
        st:=0;
        for j:=1 to len do 
        begin
            st:=st+abs(matrix[i,j]);
        end;
        if(st>s) then
        begin
            s:=st;
        end;
    end;
    write('alpha1: = ');
    writeln(s:5:4);
    //норма 2
    s:=0;
    for i:=1 to len do
    begin
        st:=0;
        for j:=1 to len do 
        begin
            st:=st+abs(matrix[j,i]);
        end;
        if(st>s) then
        begin
            s:=st;
        end;
    end;
    write('alpha2: = ');
    writeln(s:5:4);
    //норма 3
    s:=0;
    for i:=1 to len do
    begin
        for j:=1 to len do 
        begin
            s:=s+matrix2[i,j]*matrix[i,j];
        end;
        
    end;
    write('alpha3: = ');
    writeln(sqrt(s):5:4);
    writeln();
    write('n':8);
    write('x1':10);
    write('x2':10);
    write('x3':10);
    write('x4':10);
    write('bmax':10);
    writeln();

    //метод итераций
    n:=1;
    repeat
        write(n:8);
        tmpR:=result2;

        for i:=1 to len do
        begin
            result2[i]:=0;
        end;

        for i:=1 to len do
        begin
            for j:=1 to len do
            begin
                if(abs(matrix2[i,j])>0.000001) then
                begin
                    result2[i]:=result2[i]+matrix[i,j]*tmpR[j];
                    
                end;
            end;
            if(abs(matrix2[i,len+1])>0.000001) then
            begin
                result2[i]:=result2[i]+matrix[i,len+1];
            end;
            
            write(result2[i]:10:5);
        end;
        
        //PrintResult(result2);
        M:=abs(result2[1]-tmpR[1]);
        
        for i:=2 to count do
        begin
            a:=abs(result2[i]-tmpR[i]);
            if(a>M) then
            begin
                M:=a;
            end;
        end;
        writeln(M:10:5);
        Inc(n);
        
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
    printTask1(matrix1,4);
    method1(matrix1,4);
    //PrintMatrix();
    write('Result: ');
    PrintResult(result,4,3);
    writeln('==============================================================');

    printTask2(matrix2,4);
    method2(matrix2,4);
    writeln();
    write('Result: ');
    PrintResult(result2,4,4);
    writeln('==============================================================');
    //method3(matrix,umatrix,result3,3);
    //method4(result4);
    //PrintResult(result4);
end.