program InsertionSort;
type
    numbers=array of integer;
    comparator=function(a,b:integer):boolean;
var 
    f: text;
    a: integer;
    path: string;
    arr: numbers;
    //i:integer=1;
    j:integer;
    

procedure ReadFile(var arr: numbers;var f: text);
var 
    i:integer=1;
begin
    Reset(f);
    while not eof(f) do begin
        setLength(arr, i);
        read(f, a);
        Arr[i-1]:=a;
        Inc(i);
    end;
    Close(f);
end;

procedure ShowSortedArray(var arr:numbers);
begin
    Writeln('The sorted array: ');
    for j:=0 to length(arr)-1 do
    begin
        write(arr[j]);
        write(' ');
    end;
end;

function DESC (a,b:integer):boolean;
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

procedure InsertionSort(var arr:numbers; c:comparator);
var i,j,n:integer;
    a:integer;
begin
    n:= length(arr);
    for i:=1 to n-1 do begin
        a:=Arr[i];
        j:=i;
        while (j>0) and (c(Arr[j-1],a)) do begin
            Swap(arr[j],arr[j-1]);
            j:=j-1;
        end; 
        Arr[j]:=a;
    end;
end;

begin
    Write('Enter the path to the file: ');
    Readln(path);
    Assign(f,path);
    ReadFile(arr,f);
    InsertionSort(arr, @DESC);
    ShowSortedArray(arr);
    arr:=nil;

end.