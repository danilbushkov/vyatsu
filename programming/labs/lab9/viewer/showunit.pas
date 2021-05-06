unit ShowUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids;

type

  { TFormShow }

  TFormShow = class(TForm)
    StringGrid: TStringGrid;
    procedure ShowFile(path:string);
  private

  public

  end;
  TRecord = record
     id: LongWord;
     text: string[255];
     id_user: LongWord;//+
     date: LongWord;//+
     header: string[255];
     countLike: LongWord; //+
  end;

var
  FormShow: TFormShow;

implementation

{$R *.lfm}


procedure TFormShow.ShowFile(path:string);
var
  r:TRecord;
  i:integer=0;
  f:file of TRecord;
begin
   AssignFile(f, path);
   Reset(f);
   while not eof(f) do begin
     read (f, r);
     with r do
     begin
       StringGrid. Cells[0,i]:=inttostr(id);
       StringGrid. Cells[1,i]:=text;
       StringGrid. Cells[2,i]:=inttostr(id_user);
       StringGrid. Cells[3,i]:=inttostr(date);
       StringGrid. Cells[4,i]:=header;
       StringGrid. Cells[5,i]:=inttostr(countLike);
     end;
     Inc(i);
   end;
   CloseFile(f);

end;

end.

