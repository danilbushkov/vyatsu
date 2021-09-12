unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,ushapes;

type

  { TForm1 }

  TForm1 = class(TForm)

    procedure FormPaint(Sender: TObject);
  private

  public
     field: TBitmap;
  end;

var
  Form1: TForm1;



implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormPaint(Sender: TObject);
begin
    field:=TBitmap.Create;
    //faild.:=clWhite;
    field.Width:=700;
    field.Height:=500;

    ushapes.line(10,20,300,200,clwhite,field);
    circle(40,40,20,clwhite,field);
    simpleCircle(100,100,100,clwhite,field);
    self.Canvas.Draw(0,0,field);

end;

end.

