unit Sort;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Generate, GenerateUnit;


const
     countFiles=12;

type records=array of TRecord;
     comparator=function(a,b:TRecord):boolean;

procedure HeapSort(var arr:records; c:comparator);
procedure SplitFile(G:TGenerateForm);

implementation

//function DESC(a,b:TRecord):boolean;
//begin
//    //Exit(a<b);
//end;
//
//function ASC(a,b:TRecord):boolean;
//begin
//    //Exit(a>b);
//end;

procedure Swap(var a,b:TRecord);
var c: TRecord;
begin
    c:=a;
    a:=b;
    b:=c;
end;

//Сортировка пиромидой
procedure heapify(var arr:records; n,i:longint; c:comparator);
var l,r,t:longint;
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

procedure HeapSort(var arr:records; c:comparator);
var n,i:longint;
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

procedure WriteInFile(var arr:records;k,l:integer;p:string);
var f1: File of TRecord;
    i: integer;
begin

    Assign(f1,p+'\'+inttostr(k)+'.txt');
    Rewrite(f1);
    for i:=1 to l do
    begin
        Write(f1,arr[i-1]);
    end;
    Close(f1);
end;

procedure SplitFile(G:TGenerateForm);
var i,j,k: longint;
    f1: File of TRecord;
    arr: records;
    r:TRecord;
begin
    Assign(f1,g.sourceFileName);
    Reset(f1);
    i:=1;
    j:=0;//количество элементов в массиве
    k:=0;//номер файла
    setlength(arr,Filesize(f1) div countFiles);
    while not eof(f1) do begin

        read(f1,r);
        arr[j]:=r;
        Inc(j);
        if i mod (Filesize(f1) div countFiles)=0 then
        begin
            Inc(k);
            WriteInFile(arr,k,j,g.workingArea);
            j:=0;
            //arr:=nil;
        end;
        Inc(i);
    end;
    if j<>0 then begin
         Inc(k);
         WriteInFile(arr,k,j,g.workingArea);

    end;
    arr:=nil;
    close(f1);
end;



end.



