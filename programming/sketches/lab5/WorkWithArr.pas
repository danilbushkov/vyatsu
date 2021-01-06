unit WorkWithArr;


interface

type numbers=array of integer;
procedure ShowSortedArray(var arr:numbers);
procedure Swap(var a,b:integer);

implementation


procedure Swap(var a,b:integer);
var c: integer;
begin
    c:=a;
    a:=b;
    b:=c;
end;

procedure ShowSortedArray(var arr:numbers);
var j:integer;
begin
    Writeln('The sorted array: ');
    for j:=0 to length(arr)-1 do
    begin
        write(arr[j]);
        write(' ');
    end;
end;


end.