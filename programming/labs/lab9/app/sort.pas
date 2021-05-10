unit Sort;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Generate, GenerateUnit;


const
     countFiles=12;

type records=array of TRecord;
     comparator=function(a,b:TRecord):boolean;
     URecord=record
       r:TRecord;//сама запись
       a:boolean;//актуальность
     end;
     urecords=array of URecord;

procedure HeapSort(var arr:records; c:comparator);
procedure SplitFile(G:TGenerateForm);
procedure merge(G:TGenerateForm);
function CheckFile(G:TGenerateForm):boolean;

implementation

function DESC(a,b:TRecord):boolean;
begin
    if a.id_user <> b.id_user then
    begin
       Exit(a.id_user < b.id_user);
    end
    else if a.date <> b.date then
    begin
       Exit(a.date < b.date);
    end
    else
    begin
       Exit(a.countLike < b.countLike);
    end;
end;

function ASC(a,b:TRecord):boolean;
begin
    if a.id_user <> b.id_user then
    begin
       Exit(a.id_user > b.id_user);
    end
    else if a.date <> b.date then
    begin
       Exit(a.date > b.date);
    end
    else
    begin
       Exit(a.countLike > b.countLike);
    end;

end;

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

procedure WriteInFile(var arr:records;k,l:longint;p:string);
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
            HeapSort(arr,@ASC);
            Inc(k);
            WriteInFile(arr,k,j,g.workingArea);
            j:=0;
            //arr:=nil;
        end;
        Inc(i);
    end;
    if j<>0 then begin
         HeapSort(arr,@ASC);
         Inc(k);
         WriteInFile(arr,k,j,g.workingArea);

    end;
    arr:=nil;
    close(f1);
end;

function GetNeedRecord(var arr:urecords;var r:TRecord;c:comparator):integer;
var i,k:integer;
begin
     for i:=0 to length(arr)-1 do
     begin
          if arr[i].a then
          begin
               r:=arr[i].r;
               k:=i;
               break;
          end;
     end;

     for i:=1 to length(arr)-1 do
     begin
         if c(r,arr[i].r) and (arr[i].a) and (i<>k) then
         begin
             r:=arr[i].r;
             k:=i;
         end;
     end;
     GetNeedRecord:=k;
end;

procedure merge(G:TGenerateForm);
var arr:array[0..countFiles] of File of TRecord;
    r:Urecords;
    a:TRecord;
    f:File of TRecord;
    i,j,k,index:longint;
begin
     Assign(f,g.workingArea+'\sort.txt');
     Rewrite(f);
     for i:=0 to countFiles do
     begin
        Assign(arr[i],g.workingArea+'\'+inttostr(i+1)+'.txt');
        Reset(arr[i]);
     end;

     setlength(r,countFiles+1);
     for j:=0 to countFiles do
     begin
       read(arr[j],r[j].r);
       r[j].a:=true;
     end;

     index:=GetNeedRecord(r,a,@ASC);
     write(f,a);

     for i:=2 to countRecords do
     begin
          if not eof(arr[index]) then
          begin
             read(arr[index],r[index].r);
          end
          else if r[index].a then
          begin
             r[index].a:=false;
          end;
          index:=GetNeedRecord(r,a,@ASC);
          write(f,a);
     end;



     for i:=0 to countFiles do
     begin

        Close(arr[i]);
     end;
     Close(f);
end;

function CheckFile(G:TGenerateForm):boolean;
var b:boolean = true;
    f: file of Trecord;
    l,r:Trecord;
begin
     Assign(f,g.workingArea+'\sort.txt');
     Reset(f);
     read(f,l);
     While not eof(f) and b do
     begin
        read(f,r);
        if ASC(l,r) then
        begin
           b:=false;
        end;
        l:=r;
     end;
     Close(f);
     Exit(b);
end;

end.



