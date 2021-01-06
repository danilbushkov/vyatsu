unit Sort;


interface 
uses WorkWithFile,WorkWithArr,comprtr;

procedure BubbleSort(var arr:numbers; c:comparator);
procedure InsertionSort(var arr:numbers; c:comparator);

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


end.