unit FormColor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ColorBox;

type

  { TFColor }

  TFColor = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox1Click(Sender: TObject);
    procedure ColorBox2Click(Sender: TObject);
    procedure ColorBox3Click(Sender: TObject);
    procedure ColorBox4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetColor(c1,c2:Tcolor);
    procedure Shape1ChangeBounds(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape7ChangeBounds(Sender: TObject);
    procedure Shape7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

  public

  end;

var
  FColor: TFColor;
  sColor: array[0..1] of Tcolor;
  pl:integer=1;

implementation

{$R *.lfm}

{ TFColor }
 uses main,checkerunit;


procedure TFColor.FormCreate(Sender: TObject);
begin
      ColorBox1.Selected:=cllime;
      ColorBox2.Selected:=clwhite;
      ColorBox3.Selected:=clYellow;
      ColorBox4.Selected:=claqua;


      ColorBox1.AddItem('Зеленый',TObject(cllime));
      ColorBox1.AddItem('Красный',TObject(clred));


      ColorBox2.AddItem('Белый',TObject(clwhite));
      ColorBox2.AddItem('Коричневый',TObject(clMaroon));

      ColorBox3.AddItem('Желтый',TObject(clYellow));
      ColorBox3.AddItem('Синий',TObject(clblue));

      ColorBox4.AddItem('Голубой',TObject(claqua));
      ColorBox4.AddItem('Фиолетовый',TObject(clFuchsia));


end;



procedure TFColor.Button1Click(Sender: TObject);
begin
      if RadioButton1.Checked then
      begin
           sColor[0]:=ColorBox1.Selected;
           if ColorBox1.Selected=ColorBox1.Colors[0] then
           begin
              pl:=1;
              sColor[1]:=ColorBox1.Colors[1];
           end else
           begin
              pl:=2;
              sColor[1]:=ColorBox1.Colors[0];
           end;


      end;
      if RadioButton2.Checked then
      begin
          sColor[0]:=ColorBox2.Selected;
          if ColorBox2.Selected=ColorBox2.Colors[0] then
           begin
              pl:=1;
              sColor[1]:=ColorBox2.Colors[1];
           end else
           begin
              pl:=2;
              sColor[1]:=ColorBox2.Colors[0];
           end;


      end;
      if RadioButton3.Checked then
      begin
         sColor[0]:=ColorBox3.Selected;
          if ColorBox3.Selected=ColorBox3.Colors[0] then
           begin
              pl:=1;
              sColor[1]:=ColorBox3.Colors[1];
           end else
           begin
              pl:=2;
              sColor[1]:=ColorBox3.Colors[0];
           end;


      end;
      if RadioButton4.Checked then
      begin
         sColor[0]:=ColorBox4.Selected;
          if ColorBox4.Selected=ColorBox4.Colors[0] then
           begin
              pl:=1;
              sColor[1]:=ColorBox4.Colors[1];
           end else
           begin
              pl:=2;
              sColor[1]:=ColorBox4.Colors[0];
           end;

      end;

      SetColor(sColor[0],sColor[1]);

      Close();
end;

procedure TFColor.Button2Click(Sender: TObject);
begin
  Close();
end;

procedure TFColor.ColorBox1Change(Sender: TObject);
begin

end;

procedure TFColor.ColorBox1Click(Sender: TObject);
begin
  RadioButton1.Checked:=true;
end;

procedure TFColor.ColorBox2Click(Sender: TObject);
begin
    RadioButton2.Checked:=true;
end;

procedure TFColor.ColorBox3Click(Sender: TObject);
begin
    RadioButton3.Checked:=true;
end;

procedure TFColor.ColorBox4Click(Sender: TObject);
begin
    RadioButton4.Checked:=true;
end;

procedure TFColor.SetColor(c1,c2:Tcolor);
var i:integer;
begin
   //игрок
    for i:=0 to 11 do
    begin
      checkers[i].brush.Color:=c1;
      checkers[i].pen.Color:=clblack;
    end;
    //бот
    for i:=12 to 23 do
    begin
      checkers[i].brush.Color:=c2;
      checkers[i].pen.Color:=clblack;
    end;

end;

procedure TFColor.Shape1ChangeBounds(Sender: TObject);
begin

end;

procedure TFColor.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     RadioButton1.Checked:=true;
     ColorBox1.Selected:=Shape1.Brush.color;
end;

procedure TFColor.Shape2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     RadioButton1.Checked:=true;
     ColorBox1.Selected:=Shape2.Brush.color;
end;

procedure TFColor.Shape3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     RadioButton2.Checked:=true;
     ColorBox2.Selected:=Shape3.Brush.color;
end;

procedure TFColor.Shape4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     RadioButton2.Checked:=true;
     ColorBox2.Selected:=Shape4.Brush.color;
end;

procedure TFColor.Shape5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     RadioButton3.Checked:=true;
     ColorBox3.Selected:=Shape5.Brush.color;
end;

procedure TFColor.Shape6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      RadioButton3.Checked:=true;
     ColorBox3.Selected:=Shape6.Brush.color;
end;

procedure TFColor.Shape7ChangeBounds(Sender: TObject);
begin

end;


procedure TFColor.Shape7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      RadioButton4.Checked:=true;
     ColorBox4.Selected:=Shape7.Brush.color;
end;

procedure TFColor.Shape8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     RadioButton4.Checked:=true;
     ColorBox4.Selected:=Shape8.Brush.color;
end;




end.

