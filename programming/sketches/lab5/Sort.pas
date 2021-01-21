unit Sort;


interface 
uses WorkWithFile,WorkWithArr,comprtr;

procedure BubbleSort(var arr:numbers; c:comparator);
procedure InsertionSort(var arr:numbers; c:comparator);
procedure SelectionSort(var arr:numbers; c:comparator);
procedure CountingSort(var arr:numbers);
procedure HeapSort(var arr:numbers; c:comparator);
procedure QuickSort(var arr:numbers;l,h:integer; c:comparator);
procedure MergeSort(var arr: numbers; f, l: integer;c:comparator);

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


procedure CountingSort(var arr:numbers);
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

//HeapSort
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

//QuickSort

function Partition(var arr:numbers; l,h:integer; c:comparator):integer;
var t,i,j:integer;
begin
    t:=arr[h];
    i:=l;
    for j:=l to h do
    begin
        if c(t,arr[j]) then
        begin
            Swap(arr[i],arr[j]);
            i:=i+1;
        end;
    end;
    Swap(arr[i],arr[h]);
    Exit(i);
end;


procedure QuickSort(var arr:numbers;l,h:integer; c:comparator);
var p:integer;
begin
    if l < h then begin
        p := Partition(arr, l, h,c);
        QuickSort(arr, l, p - 1,c);
        QuickSort(arr, p + 1, h,c);
    end;
end;

//MargeSort

procedure Merge(var arr: numbers; f, l: integer;c:comparator);
var middle, start, final , j: integer;
    arrBuf: numbers;
begin
    setLength(arrBuf, length(arr));
    middle:=(f+l) div 2; 
    start:=f; 
    final:=middle+1; 
    for j:=f to l do 
    if (start<=middle) and ((final>l) or c(arr[final], arr[start])) then 
    begin
        arrBuf[j]:=arr[start];
        inc(start);
    end
    else
    begin
        arrBuf[j]:=arr[final];
        inc(final);
    end;
    for j:=f to l do arr[j]:=arrBuf[j];
    arrBuf:=nil;
end;

procedure MergeSort(var arr: numbers; f, l: integer;c:comparator);
begin
    if f<l then
    begin
        MergeSort(arr, f, (f+l) div 2,c); 
        MergeSort(arr, ((f+l) div 2)+1, l,c); 
        Merge(arr, f, l,c); 
    end;
end;



end.