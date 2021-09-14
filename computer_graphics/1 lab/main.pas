unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ushapes;

type

  { TForm1 }

  TForm1 = class(TForm)
    BLineBr8: TButton;
    BLineBr4: TButton;
    BCircle: TButton;
    BCircleBr: TButton;
    BLine: TButton;
    EditX1: TEdit;
    Editx2: TEdit;
    EditY1: TEdit;
    EditY2: TEdit;
    Y2: TLabel;
    Y1: TLabel;
    X2: TLabel;
    X1: TLabel;
    procedure BCircleBrClick(Sender: TObject);
    procedure BCircleClick(Sender: TObject);
    procedure BLineBr4Click(Sender: TObject);
    procedure BLineBr8Click(Sender: TObject);
    procedure BLineClick(Sender: TObject);
    procedure EditX1Change(Sender: TObject);
    procedure EditX1KeyPress(Sender: TObject; var Key: char);
    procedure Editx2KeyPress(Sender: TObject; var Key: char);
    procedure EditY1KeyPress(Sender: TObject; var Key: char);
    procedure EditY2KeyPress(Sender: TObject; var Key: char);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure FormPaint(Sender: TObject);
    procedure LineBrTimer(Sender: TObject);
    procedure getCor();
  private

  public
     bm: TBitmap;
  end;

var
  Form1: TForm1;
   tx1,tx2,ty1,ty2:integer;


implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormActivate(Sender: TObject);
begin

end;

procedure TForm1.BLineClick(Sender: TObject);
begin
   getCor();
    ushapes.uline(tx1,ty1,tx2,ty2,clwhite);

end;

procedure TForm1.EditX1Change(Sender: TObject);
begin

end;

procedure TForm1.EditX1KeyPress(Sender: TObject; var Key: char);
begin
          Editx1.ReadOnly:= not (Key in ['0'..'9',#8]);
end;

procedure TForm1.Editx2KeyPress(Sender: TObject; var Key: char);
begin
          Editx2.ReadOnly:= not (Key in ['0'..'9',#8]);
end;

procedure TForm1.EditY1KeyPress(Sender: TObject; var Key: char);
begin
          EditY1.ReadOnly:= not (Key in ['0'..'9',#8]);
end;

procedure TForm1.EditY2KeyPress(Sender: TObject; var Key: char);
begin
          EditY2.ReadOnly:= not (Key in ['0'..'9',#8]);
end;

procedure TForm1.BCircleBrClick(Sender: TObject);
begin
          getCor();
     Circle(tx1,ty1,tx2,clwhite);
end;

procedure TForm1.BCircleClick(Sender: TObject);
begin
     getCor();
  simpleCircle(tx1,ty1,tx2,clwhite);
end;

procedure TForm1.BLineBr4Click(Sender: TObject);
begin
  getCor();
     ushapes.linebr4(tx1,ty1,tx2,ty2,clwhite);
end;

procedure TForm1.BLineBr8Click(Sender: TObject);
begin
     getCor();
      ushapes.linebr8(tx1,ty1,tx2,ty2,clwhite);
end;

procedure TForm1.getCor();
begin
      tx1:=strtoint(editX1.text);
      tx2:=strtoint(editx2.text);
      ty1:=strtoint(edity1.text);
      ty2:=strtoint(edity2.text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
       bm:=TBitmap.Create;
    //faild.:=clWhite;
    bm.Width:=700;
    bm.Height:=500;




    self.Canvas.Draw(0,0,bm);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
   self.Canvas.Draw(0,0,bm);

end;

procedure TForm1.LineBrTimer(Sender: TObject);
begin

end;



end.

