unit Sort;


interface 
uses WorkWithFile,WorkWithArr,comprtr;

procedure BubbleSort(var arr:numbers; c:comparator);
procedure InsertionSort(var arr:numbers; c:comparator);
procedure SelectionSort(var arr:numbers; c:comparator);
procedure CountingSort(var arr:numbers; c:comparator);

implementation

procedure BubbleSort(var arr:numbers; c:comparator);
var i,j,n:integer;
    f:boolean;
begin
    n:= length(arr);
    for i:=1 to n-1 do begin
        f:=true;
        for j:=0 to n-1-i do begin
            if c(arr[j],arr[j+1]) then begin
                Swap(arr[j],arr[j+1]);
                f:=false;
            end;
        end; 
        if f then break;
    end;
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


procedure CountingSort(var arr:numbers; c:comparator);
var 
    max,i,j,a,n:integer;
    hArr:numbers;
begin
    n:=length(arr);
    max:=FindMaxElem(arr);
    setLength(hArr,max+1);
    for i:=0 to max do begin
        hArr[i]:=0;
    end;
    for i:=0 to n-1 do begin
        hArr[Arr[i]]:=hArr[Arr[i]]+1;
    end;
    a:=0;
    for i:=0 to max do begin
        for j:=0 to hArr[i]-1 do
        begin
            Arr[a] := i;
            a:=a+1;
        end;
    end;
    hArr:=nil;
end;

end.