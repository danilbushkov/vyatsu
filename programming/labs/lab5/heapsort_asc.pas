program heapsort_asc;

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


procedure heapify(var arr:numbers; n,i:integer; c:comparator);
var l,r,t:integer;
begin
    t:=i;
    l:=2*i+1;
    r:=2*i+2;

    if l < n then begin
        if c(arr[l], arr[t]) then
        begin
            t:=l;
        end; 
    end;

    if r < n then begin
        if c(arr[r], arr[t]) then
        begin
            t:=r;
        end;
    end;

    if t<>i then begin
        Swap(arr[i], arr[t]);
        heapify(arr,n,t,c);
    end;
end;

procedure HeapSort(var arr:numbers; c:comparator);
var n,i:integer;
begin
    n:=length(arr);

    for i:=(n div 2)-1 downto 0 do
    begin
        heapify(arr,n,i,c);
    end;
    for i:=n-1 downto 1 do
    begin
        Swap(arr[0],arr[i]);

        heapify(arr,i,0,c);
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
    HeapSort(a,@ASC);
    WriteFile(a,f1);
    
end.