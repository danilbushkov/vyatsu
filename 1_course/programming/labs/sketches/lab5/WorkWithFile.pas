unit WorkWithFile;

 

interface

uses WorkWithArr;

procedure ReadFile(var arr: numbers;var f: text);
    

implementation

procedure ReadFile(var arr: numbers;var f: text);
var 
    i:integer=1;
    a:integer;
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

end.