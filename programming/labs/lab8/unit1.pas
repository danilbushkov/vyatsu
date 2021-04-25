unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  PrintersDlgs, Printers;

type

  TFile = class(TObject)
  public
    name : String;
    exist : Boolean;
    saved : Boolean;
    constructor Create;
    procedure Reset;
    procedure MakeExist(p : String);
  end;

  { TForm1 }

  TForm1 = class(TForm)
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    ExitProgram: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    PrintDialog1: TPrintDialog;
    UndoDocument: TMenuItem;
    CutDocument: TMenuItem;
    CopyDocument: TMenuItem;
    PasteDocument: TMenuItem;
    DeleteDocument: TMenuItem;
    SelectAll: TMenuItem;
    MenuItem2: TMenuItem;
    FontText: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    InfoFile: TMenuItem;
    WordWrap: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    NewDocument: TMenuItem;
    OpenDocument: TMenuItem;
    SaveDocument: TMenuItem;
    SaveHowDocument: TMenuItem;
    PrintDocument: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Memo1Change(Sender: TObject);
    procedure ExitProgramClick(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure DeleteDocumentClick(Sender: TObject);
    procedure InfoFileClick(Sender: TObject);
    procedure SelectAllClick(Sender: TObject);
    procedure UndoDocumentClick(Sender: TObject);
    procedure CutDocumentClick(Sender: TObject);
    procedure CopyDocumentClick(Sender: TObject);
    procedure PasteDocumentClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure FontTextClick(Sender: TObject);
    procedure WordWrapClick(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure CreateDocument(Sender: TObject);
    procedure PrintDocumentClick(Sender: TObject);
    procedure OpenDocumentClick(Sender: TObject);
    procedure SaveDocumentClick(Sender: TObject);
    procedure SaveHowDocumentClick(Sender: TObject);
    procedure FormInit(Sender: TObject);
    procedure SaveNewDocument;
    procedure SaveExistDocument;
    procedure SaveAs;
    function SaveChanges:Boolean;
    procedure OpenExistDocument(p : String);
  private

  public

  end;

var
  Form1: TForm1;
  f: TFile;  //file

implementation

{$R *.lfm}

{ TForm1 }

constructor TFile.Create;
begin
  name := '';
  saved := true;
  exist := false;
  inherited Create;
end;

procedure TFile.Reset;
begin
  name := '';
  exist := false;
  saved := true;
end;

procedure TFile.MakeExist(p : String);
begin
  name := p;
  exist := true;
  saved := true;
end;



procedure TForm1.SaveNewDocument;
var
  p : String;
begin
  if SaveDialog1.Execute then
  begin
    p := SaveDialog1.FileName;
    f.MakeExist(p);
    Memo1.Lines.SaveToFile(p);
    Caption := p;
  end;
end;

procedure TForm1.SaveExistDocument;
begin

    Memo1.Lines.SaveToFile(f.name);
    f.MakeExist(f.name);

end;

procedure TForm1.SaveAs;
var
  p : String;
begin
  if SaveDialog1.Execute then
  begin
    p := SaveDialog1.FileName;
    f.MakeExist(p);
    Memo1.Lines.SaveToFile(p);
    Caption := p;
  end
end;

function TForm1.SaveChanges : Boolean;
var
  r : Longint;
begin
  if not f.saved then
  begin
    r := QuestionDlg ('Сообщение','Вы хотите сохранить изменения?',mtCustom,
    [mrYes,'Да', mrNo,'Нет', mrCancel, 'Отмена'],'');
    if r = mrYes then
    begin
      if f.exist then
        SaveExistDocument
      else
        SaveNewDocument;
      SaveChanges := f.saved;
    end
    else if r = mrNo then
    begin
      SaveChanges := true;
    end
    else
      SaveChanges := false;
  end
  else
  begin
    SaveChanges := true;
  end;
end;


procedure TForm1.OpenExistDocument(p : String);
begin
  Memo1.Lines.LoadFromFile(p);
  f.MakeExist(p);
  Caption := p;
end;





procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.FontTextClick(Sender: TObject);  //шрифт
begin
     if FontDialog1.Execute then Memo1.Font:=FontDialog1.Font;
end;

procedure TForm1.WordWrapClick(Sender: TObject);   //перенос по словам
begin
   If Memo1.WordWrap then
   begin
     Memo1.WordWrap:=false;
     Memo1.ScrollBars:=ssBoth;
     WordWrap.Checked:=False;
   end
   else
   begin
     Memo1.WordWrap:=True;
     Memo1.ScrollBars:=ssVertical;
     WordWrap.Checked:=True;
   end;
end;

procedure TForm1.FormInit(Sender: TObject);
begin
  Memo1.WordWrap:=false;
  Memo1.ScrollBars:=ssBoth;
  WordWrap.Checked:=False;
  Caption := 'Новый документ';
  f := TFile.Create;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
       f.saved:=false;
end;

procedure TForm1.ExitProgramClick(Sender: TObject);   //Закрыть программу
begin
  if SaveChanges then
  begin
     Close;
  end;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin

end;

procedure TForm1.DeleteDocumentClick(Sender: TObject);   //Удалить выделенное
begin
     Memo1.ClearSelection;
end;

procedure TForm1.InfoFileClick(Sender: TObject);    //информация о файле
var
   m:string;
   i,l:longint;
begin
  l:=0;
  for i:=0 to Memo1.Lines.Count-1 do
  begin
       l:=l+length(memo1.lines.strings[i]);

  end;
  m := 'Строк: ' + IntToStr(Memo1.Lines.Count) + chr(10) +
             'Символов: ' + IntToStr(l);
  MessageDlg('Statistics', m, mtInformation, [mbClose], 0);

end;

procedure TForm1.SelectAllClick(Sender: TObject);   //Выделить все
begin
     Memo1.SelectAll;
end;

procedure TForm1.UndoDocumentClick(Sender: TObject); //Отменить
begin
   Memo1.Undo;
end;

procedure TForm1.CutDocumentClick(Sender: TObject);    //вырезать
begin
   Memo1.CutToClipboard;
end;

procedure TForm1.CopyDocumentClick(Sender: TObject);   //копировать
begin
   Memo1.CopyToClipboard;
end;

procedure TForm1.PasteDocumentClick(Sender: TObject);   //вставить
begin
    Memo1.PasteFromClipboard;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin

end;

procedure TForm1.CreateDocument(Sender: TObject);    //Создать документ
begin
  if SaveChanges then
  begin
    Memo1.Lines.Clear;
    Caption := 'Новый документ';
    f.Reset;
  end;

end;

procedure TForm1.PrintDocumentClick(Sender: TObject);   //Печать
var
  i : Longint;
begin
    if PrintDialog1.Execute then
    begin
          Printer.BeginDoc;
          Printer.Canvas.Font := Memo1.Font;
          for i := 0 to Memo1.Lines.Count do
          begin
               Printer.Canvas.TextOut(300, 100 + i * 100, Memo1.Lines.Strings[i]);
          end;
          Printer.EndDoc;
    end;
end;

procedure TForm1.OpenDocumentClick(Sender: TObject);   //открыть документ
var
  p : String;
begin
  if f.saved then
  begin
    if OpenDialog1.Execute then
    begin
      p := OpenDialog1.FileName;
      OpenExistDocument(p);
    end;
  end
  else
  begin
    if not SaveChanges then
      exit;
    if OpenDialog1.Execute then
    begin
      p := OpenDialog1.FileName;
      OpenExistDocument(p);
    end;
  end;
end;

procedure TForm1.SaveDocumentClick(Sender: TObject);  //Сохранить документ
begin
  if f.exist then
  begin
    SaveExistDocument
  end
  else
  begin
    SaveNewDocument;
  end;
end;

procedure TForm1.SaveHowDocumentClick(Sender: TObject);   //Сохранить как
begin
     SaveNewDocument;
end;

end.

