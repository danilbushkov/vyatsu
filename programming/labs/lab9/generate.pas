unit Generate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, statusunit;

type
  TRecord = record
     id: LongWord;
     text: string[255];
     id_user: LongWord;//+
     date: LongWord;//+
     header: string[255];
     countLike: LongWord; //+
  end;

const
  countRecords = 2033602;
var f: File of TRecord;

procedure GenerateFile(path:string);

implementation

function RandomText:string;
var
   l,i:integer;
   s:string='';
begin
    l:=random(255)+1;
    for i:=1 to l do
    begin
      s:=s+Chr(Ord('a') + Random(Ord('z') - Ord('a')));
    end;
    RandomText:=s;
end;

function RandomTRecord:TRecord;
var
   r:TRecord;
begin
   with r do
   begin
     id:=random(4294967296);
     text:=RandomText;
     id_user:=random(4294967296);
     date:=random(4294967296);
     header:=RandomText;
     countLike:=random(4294967296);
   end;
   Exit(r);
end;

procedure GenerateFile(path:string);
var
   i:integer;
begin
   FormStatus.ProgressBar.Position:=0;
   FormStatus.Show;

   Assign(f, path);
   Rewrite(f);
   for i:=1 to countRecords do
   begin
       Write(f, RandomTRecord());
       if i mod (trunc(countRecords/100))=0 then
       begin
         FormStatus.ProgressBar.Position:=FormStatus.ProgressBar.Position+1;
       end;
   end;
   Close(f);
   FormStatus.Close;
end;


end.

