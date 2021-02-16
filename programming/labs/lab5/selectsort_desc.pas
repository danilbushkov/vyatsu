program selecsort_desc;

type numbers=array of integer;
     comparator=function(a,b:integer):boolean;

var 
    f:text;
    f1:text;
    a:numbers;

function DESC(a,b:integer):boolean;
begin
    Exit(a<b);
end;

function ASC(a,b:integer):boolean;
begin
    Exit(a>b);
end;

procedure Swap(var a,b:integer);
var c: integer;
begin
    c:=a;
    a:=b;
    b:=c;
end;


procedure SelectionSort(var arr:numbers; c:comparator);
var
    n,i,j,r:integer;
begin
    n:=length(arr);
    for i:=0 to n-2 do begin
        r:=i;
        for j:=i+1 to n-1 do begin
            if c(arr[r],arr[j]) then r:=j;
        end;
        if r<>i then Swap(arr[i],arr[r]);
    end;
end;




procedure ReadFile(var arr: numbers;var f: text);
var 
    i:integer=1;
    a:integer;
    c:integer;
begin
    Reset(f);
    read(f,c);
    setLength(arr, c);
    while not eof(f) do begin
        read(f, a);
        Arr[i-1]:=a;
        Inc(i);
    end;
    Close(f);
end;
procedure WriteFile(var arr: numbers;var f:text);
var l,i: integer;
begin
    Rewrite(f);
    l:=length(arr);
    for i:=0 to l-1 do 
    begin
        write(f,arr[i], ' ');
    end;
    Close(f1);
end;

begin
    Assign(f, '.\input.txt');
    Assign(f1, '.\output.txt');
    Reset(f);
    ReadFile(a,f);
    SelectionSort(a,@DESC);
    WriteFile(a,f1);
    
end.